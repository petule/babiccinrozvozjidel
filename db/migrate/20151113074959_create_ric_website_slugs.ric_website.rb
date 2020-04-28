# This migration comes from ric_website (originally 20150721151036)
class CreateRicWebsiteSlugs < ActiveRecord::Migration
	def change
		create_table :slugs do |t|
			
			t.timestamps null: true

			t.string :slug_language
			t.string :original
			t.string :translation

		end
	end
end
