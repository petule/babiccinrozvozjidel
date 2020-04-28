class AddLevelToSessionsAndOrders < ActiveRecord::Migration
  def change
  	add_column :sessions, :location_level, :string
  	add_column :orders, :customer_location_level, :string
  end
end
