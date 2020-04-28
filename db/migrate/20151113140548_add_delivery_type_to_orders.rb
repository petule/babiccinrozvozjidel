class AddDeliveryTypeToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :delivery_type, :string
  	add_column :orders, :note, :text
  end
end
