class AddColumnsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :video_url, :string
    add_column :messages, :link_url, :string
    add_column :messages, :text_url, :string
  end
end
