class RenameProductPanelsToProductVariants < ActiveRecord::Migration
  def change
  	rename_table :product_panels, :product_variants
  end
end
