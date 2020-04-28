class AddLocationAddressToSessions < ActiveRecord::Migration
  def change
  	add_column :sessions, :location_address, :string
  end
end
