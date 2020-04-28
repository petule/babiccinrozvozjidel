class AddOrderBelowMinPriceToDeliveryMapZones < ActiveRecord::Migration
  def change
  	add_column :delivery_map_zones, :order_below_min_price, :boolean
  end
end
