class RemoveNameFromChallenges < ActiveRecord::Migration
  def up
    remove_column :challenges, :name
  end
end
