class ChangeImageToFileInBanners < ActiveRecord::Migration
  def change
  	rename_column :banners, :image_file_name, :file_file_name
  	rename_column :banners, :image_content_type, :file_content_type
  	rename_column :banners, :image_file_size, :file_file_size
  	rename_column :banners, :image_updated_at, :file_updated_at
  	add_column :banners, :file_kind, :string
  end
end
