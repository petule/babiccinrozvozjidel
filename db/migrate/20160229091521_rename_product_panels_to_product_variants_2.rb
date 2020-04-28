class RenameProductPanelsToProductVariants2 < ActiveRecord::Migration
  def change
  	rename_table :product_panels_products, :product_variants_products
  end
end
