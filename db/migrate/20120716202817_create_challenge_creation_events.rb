class CreateChallengeCreationEvents < ActiveRecord::Migration
  def change
    create_table :challenge_creation_events do |t|
      t.integer :challenge_id

      t.timestamps
    end
  end
end
