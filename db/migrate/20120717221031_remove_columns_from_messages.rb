class RemoveColumnsFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :video_url
    remove_column :messages, :text_url
    add_column :messages, :media_type, :string
    add_column :messages, :url, :string
  end
end
