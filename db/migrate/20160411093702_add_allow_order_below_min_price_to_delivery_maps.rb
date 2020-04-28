class AddAllowOrderBelowMinPriceToDeliveryMaps < ActiveRecord::Migration
  def change
  	add_column :delivery_maps, :order_below_min_price, :boolean
  end
end
