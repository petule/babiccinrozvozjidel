# This migration comes from ric_assortment (originally 20150619133106)
class CreateRicAssortmentProducts < ActiveRecord::Migration
	def change
		create_table :products do |t|

			t.timestamps null: true

			# Ordering
			t.integer :position

			# Identification
			t.string :name
			t.string :catalogue_number
			t.string :ean

			# Content
			t.text :perex
			t.text :content

			# Dimensions
			t.integer :height
			t.integer :width
			t.integer :depth
			t.integer :weight
			t.integer :capacity

			# Price
			t.integer :price
			t.string :currency

			# Meta
			t.string :keywords
			t.string :description
			
		end
	end
end
