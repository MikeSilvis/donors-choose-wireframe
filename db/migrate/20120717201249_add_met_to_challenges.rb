class AddMetToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :met, :boolean, default: false
  end
end
