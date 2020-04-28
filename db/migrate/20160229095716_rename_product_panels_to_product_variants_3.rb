class RenameProductPanelsToProductVariants3 < ActiveRecord::Migration
  def change
  	rename_column :product_variants_products, :product_panel_id, :product_variant_id
  end
end
