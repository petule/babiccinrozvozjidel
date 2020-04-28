# This migration comes from ric_advert (originally 20141210172201)
class CreateRicAdvertBannerStatistics < ActiveRecord::Migration
  def change
    create_table :banner_statistics do |t|
      
      # Timestamps
      t.timestamps null: false

      # Relation to banner
      t.integer :banner_id

      # Statistics
      t.string :ip
      t.integer :impressions, null: false, default: 0
      t.integer :clicks, null: false, default: 0

    end
  end
end
