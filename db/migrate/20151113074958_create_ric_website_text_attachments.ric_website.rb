# This migration comes from ric_website (originally 20150715133603)
class CreateRicWebsiteTextAttachments < ActiveRecord::Migration
	def change
		create_table :text_attachments do |t|

			t.timestamps null: true

			# File
			t.attachment :file

			# Kind
			t.string :kind
		end
	end
end
