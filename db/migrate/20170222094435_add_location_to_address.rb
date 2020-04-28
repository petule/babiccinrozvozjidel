class AddLocationToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :address, :string
    add_column :addresses, :level, :string
    add_column :addresses, :latitude, :string
    add_column :addresses, :longitude, :string
  end
end
