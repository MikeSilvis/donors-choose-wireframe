class AddVideoHtmlToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :video_html, :string
  end
end
