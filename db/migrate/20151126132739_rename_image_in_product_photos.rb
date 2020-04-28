class RenameImageInProductPhotos < ActiveRecord::Migration
  def change
  	rename_column :product_photos, :image_file_name, :picture_file_name
  	rename_column :product_photos, :image_content_type, :picture_content_type
  	rename_column :product_photos, :image_file_size, :picture_file_size
  	rename_column :product_photos, :image_updated_at, :picture_updated_at
  end
end
