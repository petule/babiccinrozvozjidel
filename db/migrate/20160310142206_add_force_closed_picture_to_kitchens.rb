class AddForceClosedPictureToKitchens < ActiveRecord::Migration
  def change
  	remove_column :kitchens, :force_closed_note
  	add_column :kitchens, :force_closed_note, :text
  	add_attachment :kitchens, :force_closed_picture
  end
end
