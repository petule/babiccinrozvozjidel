# This migration comes from ric_website (originally 20150625092514)
class AddKeyToTexts < ActiveRecord::Migration
	def change
		add_column :texts, :key, :string
	end
end
