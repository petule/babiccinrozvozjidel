# This migration comes from ric_advert (originally 20141210161740)
class CreateRicAdvertBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      
      # Timestamps
      t.timestamps null: false

      # Relation to advertisers
      t.integer :advertiser_id
      
      # Identification
      t.string :name

      # URL
      t.string :url
      
      # Content
      t.string :kind
      t.attachment :image
      
      # Validity
      t.date :valid_from
      t.date :valid_to
      
      # Priority among other banners
      t.integer :priority

    end
  end
end
