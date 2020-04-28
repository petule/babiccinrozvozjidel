class AddColumnBonusToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :bonus, :integer, null: false, default: 0
    add_column :orders, :eligible_for_bonus, :boolean, null: false, default: false
    add_column :orders, :bonus_assigned, :boolean, null: false, default: false
  end
end
