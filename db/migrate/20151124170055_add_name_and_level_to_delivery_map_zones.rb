class AddNameAndLevelToDeliveryMapZones < ActiveRecord::Migration
  def change
  	add_column :delivery_map_zones, :name, :string
  	add_column :delivery_map_zones, :level, :integer
  end
end
