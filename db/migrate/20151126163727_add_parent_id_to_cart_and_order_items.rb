class AddParentIdToCartAndOrderItems < ActiveRecord::Migration
  def change
  	add_column :cart_items, :sub_product_ids, :string
  	add_column :cart_items, :sub_product_names, :string
  	add_column :cart_items, :sub_product_prices, :string
  	add_column :cart_items, :sub_product_currencies, :string
  	add_column :order_items, :sub_product_ids, :string
  	add_column :order_items, :sub_product_names, :string
  	add_column :order_items, :sub_product_prices, :string
  	add_column :order_items, :sub_product_currencies, :string
  end
end
