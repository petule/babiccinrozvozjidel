# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Kitchen
# *
# * Author: Matěj Outlý
# * Date  : 1. 3. 2016
# *
# *****************************************************************************

class Admin::KitchensController < AdminController

	before_action :set_kitchen, only: [:show, :edit, :update]

	#
	# Show action
	#
	def show
		respond_to do |format|
			format.html { render "show" }
			format.json { render json: @kitchen.to_json }
		end
	end

	#
	# Edit action
	#
	def edit
	end

	#
	# Update action
	#
	def update
		if @kitchen.update(kitchen_params)
			respond_to do |format|
				format.html { redirect_to main_app.admin_restaurants_path, notice: I18n.t("activerecord.notices.models.kitchen.update") }
				format.json { render json: @kitchen.id }
			end
		else
			respond_to do |format|
				format.html { render "edit" }
				format.json { render json: @kitchen.errors }
			end
		end
	end

protected

	#
	# Set model
	#
	def set_kitchen
		@kitchen = Kitchen.instance
		if @kitchen.nil?
			redirect_to main_app.root_path, alert: I18n.t("activerecord.errors.models.kitchen.not_found")
		end
	end

	# 
	# Never trust parameters from the scary internet, only allow the white list through.
	#
	def kitchen_params
		params.require(:kitchen).permit( 
			:max_delivery_time,  
			:force_closed, 
			:force_closed_note, 
			:force_closed_picture, 
		)
	end

end
