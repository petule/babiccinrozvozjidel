class AddCropPreserveToProductPhotos < ActiveRecord::Migration
  def change
  	add_column :product_photos, :picture_crop_x, :integer
  	add_column :product_photos, :picture_crop_y, :integer
  	add_column :product_photos, :picture_crop_w, :integer
  	add_column :product_photos, :picture_crop_h, :integer
  end
end
