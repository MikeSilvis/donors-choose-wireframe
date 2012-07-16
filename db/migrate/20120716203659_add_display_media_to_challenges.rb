class AddDisplayMediaToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :display_media, :string
  end
end
