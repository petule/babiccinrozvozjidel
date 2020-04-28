class AddColumnUsedBonusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :used_bonus, :integer, null: false, default: 0
  end
end
