class AddForceClosedNoteToKitchens < ActiveRecord::Migration
  def change
  	add_column :kitchens, :force_closed_note, :string
  end
end
