class RenamePaymentSessionIdInOrders < ActiveRecord::Migration
  def change
  	rename_column :orders, :payment_session_id, :payment_id
  end
end
