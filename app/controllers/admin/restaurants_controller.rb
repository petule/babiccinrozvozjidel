# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Restaurants
# *
# * Author: Matěj Outlý
# * Date  : 11. 11. 2015
# *
# *****************************************************************************

class Admin::RestaurantsController < AdminController

	before_action :set_kitchen, only: [:index]
	before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

	#
	# Index action
	#
	def index
		@restaurants = Restaurant.all.order(position: :asc)
	end

	#
	# Show action
	#
	def show
		respond_to do |format|
			format.html { render "show" }
			format.json { render json: @restaurant.to_json(methods: :profile_picture_url) }
		end
	end

	#
	# New action
	#
	def new
		@restaurant = restaurant_model.new
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
		@restaurant = restaurant_model.new(restaurant_params)
		if @restaurant.save
			respond_to do |format|
				format.html { redirect_to main_app.admin_restaurant_path(@restaurant), notice: I18n.t("activerecord.notices.models.restaurant.create") }
				format.json { render json: @restaurant.id }
			end
		else
			respond_to do |format|
				format.html { render "new" }
				format.json { render json: @restaurant.errors }
			end
		end
	end

	#
	# Update action
	#
	def update
		if @restaurant.update(restaurant_params)
			respond_to do |format|
				format.html { redirect_to main_app.admin_restaurant_path(@restaurant), notice: I18n.t("activerecord.notices.models.restaurant.update") }
				format.json { render json: @restaurant.id }
			end
		else
			puts @restaurant.errors.inspect
			respond_to do |format|
				format.html { render "edit" }
				format.json { render json: @restaurant.errors }
			end
		end
	end

	#
	# Move action
	#
	def move
		if Restaurant.move(params[:id], params[:relation], params[:destination_id])
			respond_to do |format|
				format.html { redirect_to main_app.admin_restaurants_path, notice: I18n.t("activerecord.notices.models.restaurant.move") }
				format.json { render json: true }
			end
		else
			respond_to do |format|
				format.html { redirect_to main_app.admin_restaurants_path, alert: I18n.t("activerecord.errors.models.restaurant.move") }
				format.json { render json: false }
			end
		end
	end

	#
	# Destroy action
	#
	def destroy
		@restaurant.destroy
		respond_to do |format|
			format.html { redirect_to main_app.admin_restaurants_path, notice: I18n.t("activerecord.notices.models.restaurant.destroy") }
			format.json { render json: @restaurant.id }
		end
	end

protected

	#
	# Set model
	#
	def set_restaurant
		@restaurant = Restaurant.find_by_id(params[:id])
		if @restaurant.nil?
			redirect_to main_app.admin_restaurants_path, alert: I18n.t("activerecord.errors.models.restaurant.not_found")
		end
	end

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
	def restaurant_params
		params.require(restaurant_model.model_name.param_key).permit(
			:name,
			:name_fancy, 
			:product_collection_id, 
			:perex, 
			:content, 
			:assortment, 
			:logo, 
			:show_logo_over_profile_picture,
			:profile_picture, 
			:profile_picture_crop_x, 
			:profile_picture_crop_y, 
			:profile_picture_crop_w, 
			:profile_picture_crop_h,
			:profile_picture_perform_cropping, 
			:background_picture, 
			:max_delivery_time, 
			:payment_types, 
			:voucher_types, 
			:delivery_map_id, 
			:force_closed, 
			:force_closed_note, 
			:hidden,
			:opening_hours_monday => [:min, :max],
			:opening_hours_tuesday => [:min, :max],
			:opening_hours_wednesday => [:min, :max],
			:opening_hours_thursday => [:min, :max],
			:opening_hours_friday => [:min, :max],
			:opening_hours_saturday => [:min, :max],
			:opening_hours_sunday => [:min, :max],
			:special_actions_attributes => [:id, :title, :color, :_destroy],
		)
	end

	def restaurant_model
		if @restaurant
			return @restaurant.type.constantize
		else
			if params[:type] && ["StandardRestaurant", "FastRestaurant"].include?(params[:type])
				return params[:type].constantize
			else
				return StandardRestaurant
			end
		end
	end

end
