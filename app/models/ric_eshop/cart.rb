# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Cart
# *
# * Author: Matěj Outlý
# * Date  : 12. 11. 2015
# *
# *****************************************************************************

module RicEshop
	class Cart < ActiveRecord::Base
		include RicEshop::Concerns::Models::Cart
		
		# *********************************************************************
		# Virtual items
		# *********************************************************************

		#
		# Set session model
		#
		def binded_session=(binded_session)
			@binded_session = binded_session
		end

		#
		# Get session model
		#
		def binded_session
			@binded_session
		end

		#
		# Delivery price
		#
		virtual_item do |object|
			if object.binded_session && object.binded_session.delivery_map_zone
				if (object.binded_session.delivery_map_zone && object.binded_session.delivery_map_zone.order_below_min_price == true) && (object.basic_price.to_i < object.binded_session.min_order_price.to_i)
					price = object.binded_session.delivery_price
				else
					price = 0
				end
				OpenStruct.new ({
					name: I18n.t("activerecord.attributes.ric_eshop/cart.virtual_items.delivery"), 
					price: price,
					currency: "cs"
				})
			else
				nil
			end
		end

		#
		# Package price
		#
		virtual_item do |object|
			if object.binded_session && object.binded_session.delivery_map_zone
				if (object.binded_session.delivery_map_zone && object.binded_session.delivery_map_zone.order_below_min_price == true) && (object.basic_price.to_i < object.binded_session.min_order_price.to_i)
					price = price = object.binded_session.package_price
				else
					price = 0
				end
				OpenStruct.new ({
					name: I18n.t("activerecord.attributes.ric_eshop/cart.virtual_items.package"), 
					price: price,
					currency: "cs"
				})
			else
				nil
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
				self.cart_items.each do |cart_item|
					if cart_item.restaurant && cart_item.restaurant.delivery_map_id
						@delivery_map_id = cart_item.restaurant.delivery_map_id
						break
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
				@delivery_map = DeliveryMap.find_by_id(self.delivery_map_id)
			end
			return @delivery_map
		end

		#
		# Validate delivery map crossing
		#
		validate do
			delivery_map_id = nil
			self.cart_items.each do |cart_item|
				if cart_item.restaurant && cart_item.restaurant.delivery_map_id
					if delivery_map_id.nil?
						delivery_map_id = cart_item.restaurant.delivery_map_id
					end
					if delivery_map_id != cart_item.restaurant.delivery_map_id
						errors.add(:cart_items, I18n.t("activerecord.errors.models.#{RicEshop.cart_model.model_name.i18n_key}.attributes.cart_items.delivery_maps_crossed"))
					end
				end
			end
			if @cart_items_to_add
				@cart_items_to_add.each do |cart_item_params|
					if cart_item_params[:restaurant_id]
						restaurant = Restaurant.find_by_id(cart_item_params[:restaurant_id])
						if restaurant && restaurant.delivery_map_id
							if delivery_map_id.nil?
								delivery_map_id = restaurant.delivery_map_id
							end
							if delivery_map_id != restaurant.delivery_map_id
								errors.add(:cart_items, I18n.t("activerecord.errors.models.#{RicEshop.cart_model.model_name.i18n_key}.attributes.cart_items.delivery_maps_crossed"))
							end
						end
					end
				end
			end
		end

		# *********************************************************************
		# Cleanup
		# *********************************************************************

		def self.cleanup_closed_restaurants
			result = 0
			Restaurant.all.each do |restaurant|
				if restaurant.closed?
					result += RicEshop.cart_item_model.delete_all(["restaurant_id = ?", restaurant.id])
				end
			end
			return result
		end

		#
		# Get cleanup timeout
		#
		def self.cleanup_timeout
			return 6.hour
		end

	protected

		#
		# Get all permitted params
		#
		def cart_item_permitted_params
			[:product_id, :sub_product_ids, :restaurant_id]
		end

	end
end