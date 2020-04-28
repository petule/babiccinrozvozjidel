# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Delivery map zones
# *
# * Author: Matěj Outlý
# * Date  : 24. 11. 2015
# *
# *****************************************************************************

class Admin::DeliveryMapZonesController < AdminController

	before_action :set_delivery_map_zone, only: [:show, :edit, :update, :destroy]

	#
	# Show action
	#
	def show
		respond_to do |format|
			format.html { render "show" }
			format.json { render json: @delivery_map_zone.to_json }
		end
	end

	#
	# New action
	#
	def new
		@delivery_map_zone = DeliveryMapZone.new
		if params[:delivery_map_id]
			@delivery_map_zone.delivery_map_id = params[:delivery_map_id] 
		else
			redirect_to root_path, alert: I18n.t("activerecord.errors.models.delivery_map_zone.attributes.delivery_map_id.blank")
		end
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
		@delivery_map_zone = DeliveryMapZone.new(delivery_map_zone_params)
		if @delivery_map_zone.save
			respond_to do |format|
				format.html { redirect_to main_app.admin_delivery_map_zone_path(@delivery_map_zone), notice: I18n.t("activerecord.notices.models.delivery_map_zone.create") }
				format.json { render json: @delivery_map_zone.id }
			end
		else
			respond_to do |format|
				format.html { render "new" }
				format.json { render json: @delivery_map_zone.errors }
			end
		end
	end

	#
	# Update action
	#
	def update
		if @delivery_map_zone.update(delivery_map_zone_params)
			respond_to do |format|
				format.html { redirect_to main_app.admin_delivery_map_zone_path(@delivery_map_zone), notice: I18n.t("activerecord.notices.models.delivery_map_zone.update") }
				format.json { render json: @delivery_map_zone.id }
			end
		else
			respond_to do |format|
				format.html { render "edit" }
				format.json { render json: @delivery_map_zone.errors }
			end
		end
	end

	#
	# Destroy action
	#
	def destroy
		@delivery_map_zone.destroy
		respond_to do |format|
			format.html { redirect_to main_app.admin_delivery_map_path(@delivery_map_zone.delivery_map), notice: I18n.t("activerecord.notices.models.delivery_map_zone.destroy") }
			format.json { render json: @delivery_map_zone.id }
		end
	end

protected

	#
	# Set model
	#
	def set_delivery_map_zone
		@delivery_map_zone = DeliveryMapZone.find_by_id(params[:id])
		if @delivery_map_zone.nil?
			redirect_to root_path, alert: I18n.t("activerecord.errors.models.delivery_map_zone.not_found")
		end
	end

	# 
	# Never trust parameters from the scary internet, only allow the white list through.
	#
	def delivery_map_zone_params
		params.require(:delivery_map_zone).permit(
			:delivery_map_id, 
			:name, 
			:level, 
			:polygon, 
			:min_order_price, 
			:delivery_price, 
			:package_price, 
			:delivery_time,
			:order_below_min_price
		)
	end

end
