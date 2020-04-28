# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Delivery maps
# *
# * Author: Matěj Outlý
# * Date  : 24. 11. 2015
# *
# *****************************************************************************

class Admin::DeliveryMapsController < AdminController

	before_action :set_delivery_map, only: [:show, :edit, :update, :destroy]

	#
	# Index action
	#
	def index
		@delivery_maps = DeliveryMap.all.order(:name)
	end

	#
	# Show action
	#
	def show
		respond_to do |format|
			format.html { render "show" }
			format.json { render json: @delivery_map.to_json }
		end
	end

	#
	# New action
	#
	def new
		@delivery_map = DeliveryMap.new
	end

	#
	# Edit action
	#
	def edit
	end

	#
	# Create action
	#
	def create
		@delivery_map = DeliveryMap.new(delivery_map_params)
		if @delivery_map.save
			respond_to do |format|
				format.html { redirect_to main_app.admin_delivery_map_path(@delivery_map), notice: I18n.t("activerecord.notices.models.delivery_map.create") }
				format.json { render json: @delivery_map.id }
			end
		else
			respond_to do |format|
				format.html { render "new" }
				format.json { render json: @delivery_map.errors }
			end
		end
	end

	#
	# Update action
	#
	def update
		if @delivery_map.update(delivery_map_params)
			respond_to do |format|
				format.html { redirect_to main_app.admin_delivery_map_path(@delivery_map), notice: I18n.t("activerecord.notices.models.delivery_map.update") }
				format.json { render json: @delivery_map.id }
			end
		else
			respond_to do |format|
				format.html { render "edit" }
				format.json { render json: @delivery_map.errors }
			end
		end
	end

	#
	# Destroy action
	#
	def destroy
		@delivery_map.destroy
		respond_to do |format|
			format.html { redirect_to main_app.admin_delivery_maps_path, notice: I18n.t("activerecord.notices.models.delivery_map.destroy") }
			format.json { render json: @delivery_map.id }
		end
	end

protected

	#
	# Set model
	#
	def set_delivery_map
		@delivery_map = DeliveryMap.find_by_id(params[:id])
		if @delivery_map.nil?
			redirect_to root_path, alert: I18n.t("activerecord.errors.models.delivery_map.not_found")
		end
	end

	# 
	# Never trust parameters from the scary internet, only allow the white list through.
	#
	def delivery_map_params
		params.require(:delivery_map).permit(
			:name, 
			:restrict_zone, 
			:order_below_min_price
		)
	end

end
