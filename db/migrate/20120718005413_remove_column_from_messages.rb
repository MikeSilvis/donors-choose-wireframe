class RemoveColumnFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :link_url
  end
end
