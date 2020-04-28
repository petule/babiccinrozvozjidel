class RetypeSessionIdInCartItems < ActiveRecord::Migration
  def change
  	change_column :cart_items, :session_id, :string
  end
end
