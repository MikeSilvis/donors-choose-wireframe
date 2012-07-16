class CreateChallengeMetEvents < ActiveRecord::Migration
  def change
    create_table :challenge_met_events do |t|
      t.integer :challenge_id

      t.timestamps
    end
  end
end
