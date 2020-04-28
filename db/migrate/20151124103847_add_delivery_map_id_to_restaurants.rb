class AddDeliveryMapIdToRestaurants < ActiveRecord::Migration
  def change
  	add_column :restaurants, :delivery_map_id, :integer
  end
end
