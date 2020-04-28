# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Delivery map zone
# *
# * Author: Matěj Outlý
# * Date  : 24. 11. 2015
# *
# *****************************************************************************

class DeliveryMapZone < ActiveRecord::Base

	# *************************************************************************
	# Structure
	# *************************************************************************

	belongs_to :delivery_map

	# *************************************************************************
	# Polygon
	# *************************************************************************
	
	geopolygon_column :polygon
	
	# *************************************************************************
	# Validators
	# *************************************************************************
	
	validates_presence_of :delivery_map_id, :min_order_price, :delivery_price, :package_price, :name, :level

	# *************************************************************************
	# Scopes
	# *************************************************************************

	def self.search_for_closest_zone(latitude, longitude)
		roughly_intersecting_zones = polygon_intersection(latitude, longitude).order(level: :asc)
		roughly_intersecting_zones.each do |zone|
			if zone.polygon_intersection?(latitude, longitude)
				return zone
			end
		end
		fallback_zone = where(polygon_points: nil).first
		return fallback_zone
	end

end
