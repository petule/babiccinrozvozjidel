# This migration comes from ric_assortment (originally 20150811133011)
class AddDefaultCategoryToProducts < ActiveRecord::Migration
	def change
		add_column :products, :default_product_category_id, :integer
	end
end
