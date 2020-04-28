# This migration comes from ric_user (originally 20151126075014)
class CreateRicUserSessions < ActiveRecord::Migration
	def change
		create_table :sessions, id: false do |t|

			# Timestamps
			t.timestamps null: true

			# ID
			t.string :id, null: false

			# Location
			t.float :location_latitude
			t.float :location_longitude
		end

		# Index
		add_index :sessions, :id, unique: true
	end
end
