# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Homepage
# *
# * Author: Matěj Outlý
# * Date  : 11. 6. 2015
# *
# *****************************************************************************

class HomepageController < PublicController

	#
	# Menu component
	#
	component RicAssortment::ProductsTickerComponent

	def index
		if @session.nil? || @session.location.nil? || @session.location[:address].empty?
			@session.update({location_latitude: '50.07433109999999', location_longitude: '14.3683756',
											 location_address: 'U Klikovky 3086/10, 150 00 Praha 5-Smíchov, Česko', location_level: 'address'})
			#puts "TRY session"
			#puts @session.inspect
		end
		restaurants = Restaurant.not_hidden.order(position: :asc)
		@open_restaurants = []
		@closed_restaurants = []
		restaurants.each do |restaurant|
			if restaurant.currently_open
				@open_restaurants << restaurant
			else
				if @closed_restaurants.length < 3
					@closed_restaurants << restaurant
				end
			end
		end
		@is_homepage = true
	end
end
