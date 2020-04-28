class CreateKitchens < ActiveRecord::Migration
	def change
		create_table :kitchens do |t|

			t.timestamps null: true

			# Force close all restaurants
			t.boolean :force_closed

			# Max delivery time of all restaurants
			t.time :max_delivery_time

		end
	end
end
