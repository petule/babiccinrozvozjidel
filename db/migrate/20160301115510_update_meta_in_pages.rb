class UpdateMetaInPages < ActiveRecord::Migration
  def change
  	rename_column :pages, :keywords, :meta_title
  	rename_column :pages, :description, :meta_description
  end
end
