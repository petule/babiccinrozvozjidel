# This migration comes from ric_website (originally 20150514073404)
class AddKeywordsAndDescriptionToTexts < ActiveRecord::Migration
	def change
		add_column :texts, :keywords, :string
		add_column :texts, :description, :string
	end
end
