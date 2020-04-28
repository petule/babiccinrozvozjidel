# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Create aspecial action migration
# *
# * Author: Matěj Outlý
# * Date  : 3. 3. 2016
# *
# *****************************************************************************

class CreateRestaurantActions < ActiveRecord::Migration
	def change
		create_table :special_actions do |t|
			t.timestamps null: true
			t.integer :position
			t.integer :owner_id
			t.string :owner_type
			t.string :title
			t.string :color
		end
	end
end