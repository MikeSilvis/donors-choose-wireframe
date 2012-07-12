class AddChallengeIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :challenge_id, :integer
  end
end
