class ChangeProjectIdToChallengeId < ActiveRecord::Migration
  def change
    rename_column :challenge_evidences, :project_id, :challenge_id
  end
end
