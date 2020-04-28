# This migration comes from ric_website (originally 20151007084027)
class CreateRicWebsiteSettings < ActiveRecord::Migration
	def change
		create_table :settings do |t|

			t.timestamps null: true

			# Ordering
			t.integer :position
			
			# Identification
			t.string :key
			t.string :value
			t.string :kind
			
			# Category
			t.string :category
		end
	end
end
