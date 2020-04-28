# This migration comes from ric_website (originally 20151007085526)
class IndexKeyInSettings < ActiveRecord::Migration
	def change
		add_index :settings, :key
	end
end
