class IndexKeyInSettings < ActiveRecord::Migration
	def change
		add_index :settings, :key
	end
end
