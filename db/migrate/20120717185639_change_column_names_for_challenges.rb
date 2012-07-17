class ChangeColumnNamesForChallenges < ActiveRecord::Migration
  def change
    rename_column :challenges, :name_of_challenger, :name
    rename_column :challenges, :title_of_challenge, :title
  end
end
