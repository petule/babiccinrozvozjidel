# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Order
# *
# * Author: Matěj Outlý
# * Date  : 12. 11. 2015
# *
# *****************************************************************************

module RicEshop
	class Order < ActiveRecord::Base
		include RicEshop::Concerns::Models::Order
		include RicPayment::Concerns::Models::PaymentSubject
		
		belongs_to :customer
		
		# *********************************************************************
		# Location
		# *********************************************************************
		
		geolocation_column :customer_location

		# *********************************************************************
		# Validators
		# *********************************************************************
		
		validates_presence_of :customer_name, :customer_email, :customer_phone, :customer_location, :payment_type, :delivery_type, :if => :basic_step?

		validate :validate_customer_location_level
		validate :validate_off_zone
		validate :validate_price

		# *********************************************************************
		# Steps
		# *********************************************************************

		step :basic
		step :confirmation

    #
    # Is locked for editing?
    #
    def locked?
      return (self.payment_price > 0 && payment_in_progress?) # || paid?
    end
    
    
		# *********************************************************************
		# Process
		# *********************************************************************
		
		enum process_state: [:process_created, :process_kitchen, :process_shipping, :process_delivered, :process_closed, :process_canceled]
		
		attr_accessor :use_bonus
		
		alias_method :set_process_state, :process_state=
		def process_state=(val)
			set_process_state(val)
			time_column = val.to_s + '_at'
			if val.kind_of?(Numeric)
				time_column = self.class.process_states.key(val).to_s + '_at'
			end
			time_column.sub!(/^process_/, '')
			self.send("#{time_column}=", Time.now)
			if self.customer_id && self.eligible_for_bonus && !self.bonus_assigned && (['offline', 'paid'].include?(self.payment_state)) && time_column == 'delivered_at'
				bonus_percent = RicWebsite::Helpers::SettingHelper.setting_get("bonus_percent").to_s.to_f
				customer.bonus += ( (self.payment_price.to_i / 100.0) * bonus_percent ).to_i
				customer.save!
				self.bonus_assigned = true
				self.save!
			end
		end

		def self.process_state_attributes_for_select
			process_states.map do |process_state, _|
				[I18n.t("activerecord.attributes.#{model_name.i18n_key}.process_states.#{process_state}"), process_state]
			end
		end

		def normalize_used_bonus
			self.used_bonus = 0 unless customer.present?
			self.used_bonus = 0 if self.used_bonus.to_i < 0
			self.used_bonus = customer.bonus.to_i if customer && self.used_bonus.to_i > customer.bonus.to_i
			self.used_bonus = final_price.to_i if self.used_bonus.to_i > final_price.to_i
		end
		
		# *********************************************************************
		# Forwarding
		# *********************************************************************
		
		enum_column :forward_state, ["forwarded", "not_forwarded"]

		#
		# Forward state
		#
		def forward_state
			return "forwarded" if forwarded?
			return "not_forwarded"
		end

		#
		# Is order forwarded?
		#
		def forwarded?
			return !self.forwarded_at.nil?
		end

		#
		# Finalize order by forwarding it to production
		#
		def forward
			
			begin 

				# Deliver e-mail to restaurant
				RicEshop::OrderMailer.restaurant_notice(self).deliver_now

				# Save
				self.forwarded_at = Time.current
				self.override_accept_terms
				self.save

			rescue Net::SMTPFatalError, Net::SMTPSyntaxError
			end

			begin 

				# Deliver e-mail to customer
				RicEshop::OrderMailer.customer_acknowledge(self).deliver_now

			rescue Net::SMTPFatalError, Net::SMTPSyntaxError
			end

			return true
		end

		#
		# In case of offline payment => forward to production
		#
		after_create do 
			if self.payment_type != "online" && self.payment_type != "online_ferbuy"
				self.forward
			end		
		end

		# *********************************************************************
		# Delivery time
		# *********************************************************************

		enum_column :delivery_time_kind, ["now", "later"]

		def delivery_time_kind
			if self.delivery_time.nil?
				return "now"
			else
				return "later"
			end
		end

		def delivery_time_formatted
			if self.delivery_time.nil?
				return I18n.t("activerecord.attributes.ric_eshop/order.delivery_time_kind_values.now")
			else
				return I18n.t("activerecord.attributes.ric_eshop/order.delivery_time_kind_values.later") + " - " + I18n.l(self.delivery_time)
			end
		end

		# *********************************************************************
		# Delivery map
		# *********************************************************************

		#
		# Current delivery map id
		#
		def delivery_map_id
			if @delivery_map_id.nil?
				if self.new_record?
					@delivery_map_id = self.cart.delivery_map_id
				else
					self.order_items.each do |order_item|
						if order_item.restaurant && order_item.restaurant.delivery_map_id
							@delivery_map_id = order_item.restaurant.delivery_map_id
							break
						end
					end
				end
			end
			return @delivery_map_id
		end

		#
		# Current delivery map
		#
		def delivery_map
			if @delivery_map.nil?
				@delivery_map = DeliveryMap.find_by_id(self.delivery_map_id) || DeliveryMap.find_by_id(1)
			end
			return @delivery_map
		end

		#
		# Current delivery map zone
		#
		def delivery_map_zone
			if @delivery_map_zone.nil? 
				if self.delivery_map
					if self.customer_location
						@delivery_map_zone = self.delivery_map.delivery_map_zones.search_for_closest_zone(self.customer_location[:latitude], self.customer_location[:longitude])
					else
						#@delivery_map_zone = self.delivery_map.delivery_map_zones.order(level: :desc).first # Location not defined
					end
				end
			end
			return @delivery_map_zone
		end

		# *********************************************************************
		# Price
		# *********************************************************************

		#
		# Fill up final price for customer
		#
		before_create :compute_final_price

		#
		# Get minimal order price for current cart / delivery map
		#
		def min_price
			if @min_price.nil?
				if self.customer_location
				
					# Get delivery map
					if self.delivery_map
						
						# Get delivery map zone
						delivery_map_zone = self.delivery_map.delivery_map_zones.search_for_closest_zone(self.customer_location[:latitude], self.customer_location[:longitude])
						if delivery_map_zone
								
							# Get minimal order price
							@min_price = delivery_map_zone.min_order_price

						end
					end
				end
			end
			return @min_price
		end

		#
		# Get basic price
		#
		def basic_price
			if self.new_record?
				return self.cart.final_price
			else
				return self.price
			end
		end

		#
		# Supplement to min price
		#
		def supplement_price
			return self.final_price - self.basic_price
		end

		#
		# Get final proce
		#
		def final_price
			value = read_attribute(:final_price)
			if value.nil?
				compute_final_price
				value = read_attribute(:final_price)
			end
			return value
		end

		#
		# Customer wants to pay min price supplement
		#
		attr_accessor :override_min_price
		def override_min_price=(override_min_price)
			@override_min_price = (override_min_price == "1" || override_min_price == true)
		end

		# *********************************************************************
		# Payment
		# *********************************************************************

		enum_column :payment_state, ["paid", "in_progress", "not_paid", "offline"]

		#
		# Price for ThePay
		#
		def payment_price
			return self.final_price - self.used_bonus
		end

		#
		# Customer address (street, number, city, zipcode) for ThePay
		#
		def payment_customer_address
			parsed_address = RicEshop::Order.parse_address(self.customer_location_address)
			return {
				street: parsed_address[3],
				number: parsed_address[4],
				city: parsed_address[2],
				zipcode: parsed_address[1]
			}
		end

		#
		# Payment state
		#
		def payment_state
			return "offline" if self.payment_type != "online" && self.payment_type != "online_ferbuy"
			return "paid" if paid?
			return "in_progress" if payment_in_progress?
			return "not_paid"
		end

		#
		# Pay for the order, finalize action by forwarding to production
		#
		def self.pay_finalize(order_id)

			order = RicEshop.order_model.find_by_id(order_id)
			if !order
				return false
			end

			# Stop if not paid
			if !order.paid?
				return false
			end

			# Forward
			order.forward

			return true

    end

    def cancel_payment
      if self.customer_id && self.used_bonus > 0
        self.customer.bonus += self.used_bonus
        self.customer.save!
      end
      super
    end

		# *********************************************************************
		# Session / cart
		# *********************************************************************

		def session
			if @session.nil?
				@session = RicUser.session_model.find_or_create(self.session_id)
			end
			return @session
		end

		def cart
			if @cart.nil?
				@cart = RicEshop.cart_model.find(self.session_id)
				@cart.binded_session = self.session # Bind correct session for virtual attributes
			end
			return @cart
		end

		#
		# Synchronize location back to session after validation
		#
		after_validation do
			if !self.customer_location.nil?
				self.session.location = self.customer_location
				self.session.save
			end
		end

		# *********************************************************************
		# Terms
		# *********************************************************************

		#
		# Override accept terms and min price validation
		#
		def override_accept_terms
			self.accept_terms = true
			self.override_min_price = true
		end

	protected

		#
		# Order price must match the minimal order price limit
		#
		def validate_price

			# Not basic step => no validation
			if !self.confirmation_step?
				return
			end

			# If condition has some meaning
			if self.delivery_map_zone && self.delivery_map_zone.order_below_min_price != true && !self.min_price.nil?
					
				# Compare basic and minimal price
				if self.basic_price.to_i < self.min_price.to_i && self.override_min_price != true
					errors.add(:override_min_price, I18n.t("activerecord.errors.models.#{RicEshop.order_model.model_name.i18n_key}.attributes.override_min_price.blank"))
				end

			end

		end

		def validate_off_zone
			
			# Not basic step => no validation
			if !self.basic_step?
				return
			end

			# Location not defined => no validation
			if self.customer_location.nil?
				return
			end
			
			# Check if location is in some delivery zone (only if map restricts zone)
			if self.delivery_map.restrict_zone
				delivery_map_zone = self.delivery_map.delivery_map_zones.search_for_closest_zone(self.customer_location[:latitude], self.customer_location[:longitude])
				if delivery_map_zone.nil?
					errors.add(:customer_location, I18n.t("activerecord.errors.models.#{RicEshop.order_model.model_name.i18n_key}.attributes.customer_location.off_zone"))
				end
			end

		end

		def validate_customer_location_level
			
			# Not basic step => no validation
			if !self.basic_step?
				return
			end

			# Location not defined => no validation
			if self.customer_location.nil?
				return
			end
			
			# Check if location level is most specific
			if self.customer_location[:level] != "address"
				errors.add(:customer_location, I18n.t("activerecord.errors.models.#{RicEshop.order_model.model_name.i18n_key}.attributes.customer_location.level_too_vague"))
			end
		end

		#
		# Move items from cart to order
		#
		def synchronize_items
			if !self.session_id.blank?
				self.cart.cart_items.each do |cart_item|
					self.order_items.create(product_id: cart_item.product_id, sub_product_ids: cart_item.sub_product_ids, restaurant_id: cart_item.restaurant_id, amount: cart_item.amount)
				end
				self.cart.virtual_items.each do |virtual_item|
					self.order_items.create(product_name: virtual_item.name, product_price: virtual_item.price, product_currency: virtual_item.currency, amount: 1)
				end
				self.cart.clear
			end
		end

		#
		# Compute final proce
		#
		def compute_final_price
			if self.delivery_map_zone
				if self.delivery_map_zone.order_below_min_price != true
					if self.basic_price >= self.min_price.to_i
						self.final_price = self.basic_price # basic price above min price
					elsif self.override_min_price == true
						self.final_price = self.min_price
					else
						self.final_price = self.min_price
						# price validation incorrect => should not be created
					end
				else
					self.final_price = self.basic_price # basic price above or below min price (who cares...)
				end
			else
				# no order items => should not be created
			end
		end

	end
end