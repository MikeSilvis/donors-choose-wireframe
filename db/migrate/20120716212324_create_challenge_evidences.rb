class CreateChallengeEvidences < ActiveRecord::Migration
  def change
    create_table :challenge_evidences do |t|
      t.integer :project_id
      t.string :image

      t.timestamps
    end
  end
end
