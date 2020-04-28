# This migration comes from ric_website (originally 20150907115731)
class AddLayoutToPages < ActiveRecord::Migration
	def change
		add_column :pages, :layout, :string
	end
end
