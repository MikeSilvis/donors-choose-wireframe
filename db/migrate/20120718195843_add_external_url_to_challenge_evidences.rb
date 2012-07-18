class AddExternalUrlToChallengeEvidences < ActiveRecord::Migration
  def change
    add_column :challenge_evidences, :external_url, :string
  end
end
