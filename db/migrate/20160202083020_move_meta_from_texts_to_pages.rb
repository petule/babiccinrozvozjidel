class MoveMetaFromTextsToPages < ActiveRecord::Migration
	def change
		remove_column :texts, :keywords
		remove_column :texts, :description
		add_column :pages, :keywords, :string
		add_column :pages, :description, :string
	end
end
