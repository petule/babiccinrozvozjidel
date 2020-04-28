class AddCustomerLocationAddressToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :customer_location_address, :string
  end
end
