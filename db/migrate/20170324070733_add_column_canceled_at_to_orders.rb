class AddColumnCanceledAtToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :canceled_at, :datetime, null: true, default: nil
  end
end
