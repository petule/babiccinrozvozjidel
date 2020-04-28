class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :customer, index: true, foreign_key: true
      t.string :street
      t.string :city
      t.string :zip
      t.string :country
      t.text :note

      t.timestamps null: false
    end
  end
end
