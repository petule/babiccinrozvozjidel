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

require_dependency "ric_eshop/admin_controller"

module RicEshop
	class AdminOrdersController < AdminController
		include RicEshop::Concerns::Controllers::Admin::OrdersController

		def update
			if @order.locked?
				redirect_to order_path(@order), alert: I18n.t("activerecord.errors.models.#{RicEshop.order_model.model_name.i18n_key}.locked")
			else
				@order.override_accept_terms
				if @order.update(order_params)
					respond_to do |format|
						format.html do
							redirect_to order_path(@order), notice: I18n.t("activerecord.notices.models.#{RicEshop.order_model.model_name.i18n_key}.update")
						end
						format.json do
							render json: { status: :ok }
						end
					end
				else
					render "edit"
				end
			end
		end
	private

		def order_params
			params.require(:order).permit(
				:customer_id, 
				:customer_name, 
				:customer_email, 
				:customer_phone, 
				:currency, 
				:payment_type, 
				:delivery_type, 
				:delivery_time, 
				:note,
				:process_state,
				:customer_location => [:latitude, :longitude, :address, :level]
			)
		end

	end
end