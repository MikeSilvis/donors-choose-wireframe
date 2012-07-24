class AddUserIdToChallengeEvidences < ActiveRecord::Migration
  def change
    add_column :challenge_evidences, :user_id, :integer
  end
end
