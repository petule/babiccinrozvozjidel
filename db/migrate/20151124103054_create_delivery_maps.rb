# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Create map migration
# *
# * Author: 
# * Date  : 24. 11. 2015
# *
# *****************************************************************************

class CreateDeliveryMaps < ActiveRecord::Migration
	def change
		create_table :delivery_maps do |t|
			t.timestamps null: true
			t.string :name
		end
	end
end