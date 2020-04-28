class AddNameToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :name_firstname, :string
  	add_column :users, :name_lastname, :string
  end
end
