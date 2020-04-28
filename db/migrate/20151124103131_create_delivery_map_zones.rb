# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Create map zone migration
# *
# * Author: 
# * Date  : 24. 11. 2015
# *
# *****************************************************************************

class CreateDeliveryMapZones < ActiveRecord::Migration
	def change
		create_table :delivery_map_zones do |t|
			t.timestamps null: true
			t.integer :delivery_map_id
			t.string :polygon_points
			t.float :polygon_top
			t.float :polygon_bottom
			t.float :polygon_left
			t.float :polygon_right
			t.integer :min_order_price
			t.integer :devivery_price
			t.integer :package_price
			t.integer :delivery_time
		end
	end
end