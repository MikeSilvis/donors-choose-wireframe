class AddAndRemoveAttrsFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :video_html
    remove_column :messages, :media_type
    remove_column :messages, :url
    add_column :messages, :display_html, :string
  end
end
