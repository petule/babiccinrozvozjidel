class AddShowLogoOverProfilePictureToRestaurants < ActiveRecord::Migration
  def change
  	add_column :restaurants, :show_logo_over_profile_picture, :boolean
  end
end
