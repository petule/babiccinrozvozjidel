# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Session
# *
# * Author: Matěj Outlý
# * Date  : 26. 11. 2015
# *
# *****************************************************************************

module RicUser
	class Session < ActiveRecord::Base
		include RicUser::Concerns::Models::Session

		# *********************************************************************
		# Location
		# *********************************************************************

		geolocation_column :location
		
		# *********************************************************************
		# Cart
		# *********************************************************************

		def cart
			if @cart.nil?
				@cart = RicEshop.cart_model.find(self.id)
				@cart.binded_session = self # Bind correct session for virtual attributes
			end
			return @cart
		end

		# *********************************************************************
		# Map
		# *********************************************************************

		def delivery_map
			if @delivery_map.nil?
				@delivery_map = self.cart.delivery_map
			end
			if @delivery_map.nil?
				@delivery_map = DeliveryMap.find_by_id(1) # Delivery map not defined in cart => use first delivery map
			end
			return @delivery_map
		end

		def delivery_map_zone
			if @delivery_map_zone.nil? 
				if self.delivery_map
					if self.location
						@delivery_map_zone = self.delivery_map.delivery_map_zones.search_for_closest_zone(self.location[:latitude], self.location[:longitude])
					else
						#@delivery_map_zone = self.delivery_map.delivery_map_zones.order(level: :desc).first # Location not defined
					end
				end
			end
			return @delivery_map_zone
		end

		def min_order_price
			if self.delivery_map_zone
				self.delivery_map_zone.min_order_price
			else
				return nil
			end
		end

		def delivery_price
			if self.delivery_map_zone
				self.delivery_map_zone.delivery_price
			else
				return nil
			end
		end

		def package_price
			if self.delivery_map_zone
				self.delivery_map_zone.package_price
			else
				return nil
			end
		end

		def delivery_time
			if self.delivery_map_zone
				self.delivery_map_zone.delivery_time
			else
				return nil
			end
		end

		# *********************************************************************
		# Cleanup
		# *********************************************************************

		def self.cleanup
			now = Time.current
			RicUser.session_model.delete_all(["updated_at < ?", (now - self.cleanup_timeout)])
		end

		def self.cleanup_timeout
			return 1.day
		end

	end
end