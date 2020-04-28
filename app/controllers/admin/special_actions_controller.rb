# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Special actions
# *
# * Author: Matěj Outlý
# * Date  : 3. 3. 2016
# *
# *****************************************************************************

class Admin::SpecialActionsController < AdminController

	before_action :set_special_action, only: [:move, :destroy]

	#
	# Move action
	#
	def move
		if SpecialAction.move(params[:id], params[:relation], params[:destination_id])
			respond_to do |format|
				format.html do
					flash[:notice] = I18n.t("activerecord.notices.models.special_action.move")
					if @special_action.owner_type == "Restaurant"
						redirect_to main_app.admin_restaurant_path(@special_action.owner_id) 
					elsif @special_action.owner_type == "RicAssortment::Product"
						redirect_to ric_assortment_admin.product_path(@special_action.owner_id) 
					else
						redirect_to main_app.root_path
					end
				end
				format.json { render json: true }
			end
		else
			respond_to do |format|
				format.html { redirect_to main_app.root_path, alert: I18n.t("activerecord.errors.models.special_action.move") }
				format.json { render json: false }
			end
		end
	end

	#
	# Destroy action
	#
	def destroy
		@special_action.destroy
		respond_to do |format|
			format.html do
				flash[:notice] = I18n.t("activerecord.notices.models.special_action.destroy")
				if @special_action.owner_type == "Restaurant"
					redirect_to main_app.admin_restaurant_path(@special_action.owner_id) 
				elsif @special_action.owner_type == "RicAssortment::Product"
					redirect_to ric_assortment_admin.product_path(@special_action.owner_id) 
				else
					redirect_to main_app.root_path
				end
			end
			format.json { render json: @restaurant.id }
		end
	end

protected

	#
	# Set model
	#
	def set_special_action
		@special_action = SpecialAction.find_by_id(params[:id])
		if @special_action.nil?
			redirect_to main_app.root_path, alert: I18n.t("activerecord.errors.models.special_action.not_found")
		end
	end

end
