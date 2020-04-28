class AddCropPreserveToRestaurants < ActiveRecord::Migration
  def change
  	add_column :restaurants, :profile_picture_crop_x, :integer
  	add_column :restaurants, :profile_picture_crop_y, :integer
  	add_column :restaurants, :profile_picture_crop_w, :integer
  	add_column :restaurants, :profile_picture_crop_h, :integer
  end
end
