class AddHiddenToRestaurants < ActiveRecord::Migration
  def change
  	add_column :restaurants, :hidden, :boolean
  end
end
