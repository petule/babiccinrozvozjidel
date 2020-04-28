# This migration comes from ric_website (originally 20150907115625)
class AddBackgroundToPages < ActiveRecord::Migration
	def change
		add_attachment :pages, :background
	end
end
