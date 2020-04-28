class AddRestrictZoneToDeliveryMaps < ActiveRecord::Migration
  def change
  	add_column :delivery_maps, :restrict_zone, :boolean
  end
end
