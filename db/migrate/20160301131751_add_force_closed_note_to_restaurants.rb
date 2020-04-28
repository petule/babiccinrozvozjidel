class AddForceClosedNoteToRestaurants < ActiveRecord::Migration
  def change
  	add_column :restaurants, :force_closed_note, :string
  end
end
