class AddColumnProcessStateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :process_state, :integer, null: false, default: 0
    add_column :orders, :kitchen_at, :datetime, null: true, default: nil
    add_column :orders, :shipping_at, :datetime, null: true, default: nil
    add_column :orders, :delivered_at, :datetime, null: true, default: nil
    add_column :orders, :closed_at, :datetime, null: true, default: nil
  end
end
