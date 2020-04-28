class AddStiToRestaurants < ActiveRecord::Migration
  def change
  	add_column :restaurants, :type, :string
  	rename_column :restaurants, :product_category_id, :product_collection_id
  	add_column :restaurants, :product_collection_type, :string
  end
end
