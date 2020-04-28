class RenameDeliveryPriceInDeliveryMapZones < ActiveRecord::Migration
  def change
  	rename_column :delivery_map_zones, :devivery_price, :delivery_price
  end
end
