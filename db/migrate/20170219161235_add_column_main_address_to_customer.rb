class AddColumnMainAddressToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :main_address, :integer
    add_foreign_key :customers, :addresses, column: :main_address
  end
end
