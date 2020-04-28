# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Orders
# *
# * Author: Matěj Outlý
# * Date  : 12. 11. 2015
# *
# *****************************************************************************

require_dependency "ric_eshop/public_controller"

module RicEshop
	class PublicOrdersController < PublicController
		include RicEshop::Concerns::Controllers::Public::OrdersController

		before_action :set_online_payment_forcing, only: [:new, :create]

		def new
			if customer_signed_in?
				if @order.current_step == 'basic'
          @order.customer = current_customer
          @order.customer_name = current_customer.name
          @order.customer_email = current_customer.email
          @order.customer_phone = current_customer.phone
          if current_customer.addresses.count == 1
            @address = current_customer.addresses.first
            @order.note = @address.note
					end
					@order.eligible_for_bonus = true
				else
					@order.customer = current_customer
				end
			end
			super
			@order.used_bonus = params[:order][:used_bonus].to_i if params[:order] && params[:order][:used_bonus].present?
			@order.normalize_used_bonus
		end
		#
		# Create action
		#
		def create
			
			# Next step or save
			if order_with_payment_valid?
				if params[:back_button]
					@order.previous_step
				elsif @order.last_step?
					if @order.all_valid?
						if customer_signed_in?
							@order.customer = current_customer
							@order.eligible_for_bonus = true
							if @order.use_bonus.to_s == '1'
								@order.normalize_used_bonus
								current_customer.bonus -= @order.used_bonus
								current_customer.save!
							end
						end
						@order.save
					end
				else
					@order.next_step
				end
				save_step_to_session(@order.current_step)
			end
			
			# Save errors
			save_errors_to_session(@order.errors)
			
			# Render form or redirect if @order already created
			if !@order.new_record?

				# Check payment type
				if @order.payment_price > 0 && @order.payment_type == "online_ferbuy" # Redirect to FerBuy or if payment is online ferbuy
					redirect_to ric_payment_ferbuy_public.payment_path(@order.id)

				elsif @order.payment_price > 0 && @order.payment_type == "online" # Redirect to ThePay if payment is online

					# Create backend
					@payment_backend = RicPaymentThepay::Backend.instance
					@payment_backend.return_url = ric_payment_public.done_payment_url(@order)

					# Create payment
					@payment = @payment_backend.payment_from_subject(@order)

					# Redirect
					redirect_to RicPaymentThepay::Helpers::MerchantHelper.thepay_radio_merchant_redirect_url(@payment, load_thepay_params_from_session)

				else # Redirect to finalize action if payment is offline or 0
					if @order.payment_price <= 0 && (@order.payment_type == 'online_ferbuy' || @order.payment_type == 'online')
						@order.paid_at = Time.now
						@order.payment_type = 'offline'
						@order.override_accept_terms
						@order.save!
						@order.class.pay_finalize(@order.id)
					end
					redirect_to order_created_path, notice: I18n.t("activerecord.notices.models.#{RicEshop.order_model.model_name.i18n_key}.create")
				end

				# Order is complete => session can be deleted
				clear_session
			else

				# Next step or errors in current step
				redirect_to ric_eshop_public.new_order_path
			end
		end

	protected

		# *********************************************************************
		# Default values
		# *********************************************************************

		def set_order_default_values_for_new_session
			@order.customer_location = @session.location if @order.customer_location.blank? && @session && @session.location
			@order.override_min_price = true if params[:override_min_price] == "1"
			@order.delivery_type = "delivery_service"
			@order.payment_type = "online" if @force_online_payment
		end

		def set_order_default_values_for_existing_session
			@order.payment_type = "online" if @force_online_payment 
			#@order.cart_price = @cart.price # In order to validate minimal price conditions 
		end

		# *********************************************************************
		# Model setters
		# *********************************************************************

		#
		# Check if online payment is forced
		#
		def set_online_payment_forcing
			online_payment_limit = RicWebsite::Helpers::SettingHelper.setting_get("online_payment_limit")
			online_payment_restricted = RicWebsite::SettingsCollection.online_payment_restricted
			@force_online_payment = online_payment_restricted && !online_payment_limit.blank? && (@cart.final_price.to_i > online_payment_limit.to_i)
		end

		def set_cart
			# Already set...
		end

		#
		# Is order valid?
		#
		def order_with_payment_valid?
			if @order.valid?
				if @order.basic_step? && @order.payment_type == "online" 
					if RicPaymentThepay::Helpers::MerchantHelper.thepay_radio_merchant_check(params)
						save_thepay_params_to_session(params.permit(:tp_radio_selected, :tp_radio_value))
						return true
					else
						@order.errors.add(:payment_method, I18n.t("activerecord.errors.models.#{RicEshop.order_model.model_name.i18n_key}.attributes.payment_method.blank"))
						return false
					end
				else 
					return true
				end
			else
				return false
			end
		end

		# *********************************************************************
		# Session
		# *********************************************************************

		def save_thepay_params_to_session(params)
			session[session_key] = {} if session[session_key].nil?
			session[session_key]["thepay_params"] = params if !params.nil?
		end

		def load_thepay_params_from_session
			return session[session_key]["thepay_params"] if !session[session_key].nil? && !session[session_key]["thepay_params"].nil?
			return {}
		end

		def clear_thepay_params_from_session
			session[session_key].delete("thepay_params") if !session[session_key].nil? && !session[session_key]["thepay_params"].nil?
		end

		# *********************************************************************
		# Param filters
		# *********************************************************************

		#
		# Never trust parameters from the scary internet, only allow the white list through.
		#
		def order_params
			if params[:order]
				params[:order].permit(
					:session_id, 
					:customer_id, 
					:customer_name, 
					:customer_email, 
					:customer_phone, 
					:payment_type, 
					:delivery_type, 
					:delivery_time,
					:accept_terms,
					:use_bonus,
					:used_bonus,
					:note, 
					:override_min_price, 
					:customer_location => [:latitude, :longitude, :address, :level]
				)
			else
				return {}
			end
		end

	end
end