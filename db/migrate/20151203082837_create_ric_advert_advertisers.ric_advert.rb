# This migration comes from ric_advert (originally 20141210163131)
class CreateRicAdvertAdvertisers < ActiveRecord::Migration
  def change
    create_table :advertisers do |t|
      
      # Timestamps
      t.timestamps null: false

      # Identification
      t.string :name
      
    end
  end
end
