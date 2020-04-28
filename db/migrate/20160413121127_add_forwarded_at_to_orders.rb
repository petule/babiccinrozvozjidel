class AddForwardedAtToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :forwarded_at, :datetime
  end
end
