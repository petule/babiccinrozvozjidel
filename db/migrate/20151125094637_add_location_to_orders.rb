class AddLocationToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :customer_location_latitude, :float
  	add_column :orders, :customer_location_longitude, :float
  end
end
