# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Restaurants
# *
# * Author: Matěj Outlý
# * Date  : 13. 11. 2015
# *
# *****************************************************************************

class RestaurantsController < PublicController
	
	#
	# Set model before some actions
	#
	before_action :set_restaurant, only: [:show]
	
	#
	# Implement broadcast which gathers all title messages
	#
	implement_broadcast :title

	#
	# Show action
	#
	def show
	end

protected
	
	#
	# Get title of current restaurant model (if any)
	#
	def receive_title(arguments)
		if @restaurant
			return @restaurant.name
		else
			return nil
		end
	end

	#
	# Set current restaurant model
	#
	def set_restaurant
		@restaurant = Restaurant.find_by_id(params[:id])
		if @restaurant.nil?
			redirect_to root_path, alert: I18n.t("activerecord.errors.models.restaurant.not_found")
		end
	end

end
