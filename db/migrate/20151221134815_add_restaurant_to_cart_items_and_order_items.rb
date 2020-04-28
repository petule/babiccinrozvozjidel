class AddRestaurantToCartItemsAndOrderItems < ActiveRecord::Migration
  def change
  	add_column :cart_items, :restaurant_id, :integer
  	add_column :order_items, :restaurant_id, :integer
  end
end
