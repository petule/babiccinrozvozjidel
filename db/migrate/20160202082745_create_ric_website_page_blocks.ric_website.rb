# This migration comes from ric_website (originally 20160128061454)
class CreateRicWebsitePageBlocks < ActiveRecord::Migration
	def change
		create_table :page_blocks do |t|

			# Timestamps
			t.timestamps null: true

			# Position
			t.integer :position
	
			# Relation to page
			t.integer :page_id

			# Subject
			t.integer :subject_id
			t.string :subject_type

		end
	end
end
