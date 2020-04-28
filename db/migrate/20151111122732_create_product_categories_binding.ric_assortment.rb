# This migration comes from ric_assortment (originally 20150619140127)
class CreateProductCategoriesBinding < ActiveRecord::Migration
	def change
		create_table :product_categories_products, id: false do |t|

			t.timestamps null: true

			# Bind
			t.integer :product_id
			t.integer :product_category_id

		end
	end
end
