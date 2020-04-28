# *****************************************************************************
# * Copyright (c) Clockstar s.r.o. All rights reserved.
# *****************************************************************************
# *
# * Create restaurant migration
# *
# * Author: 
# * Date  : 11. 11. 2015
# *
# *****************************************************************************

class CreateRestaurants < ActiveRecord::Migration
	def change
		create_table :restaurants do |t|
			t.timestamps null: true
			t.integer :position
			t.string :name
			t.string :perex
			t.string :assortment
			t.text :content
			t.attachment :logo
			t.attachment :profile_picture
			t.attachment :background_picture
			t.string :max_delivery_time
			t.string :payment_types
			t.string :voucher_types
			t.integer :product_category_id
		end
	end
end