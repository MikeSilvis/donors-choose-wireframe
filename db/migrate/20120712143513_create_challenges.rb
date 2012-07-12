class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name_of_challenger
      t.string :title_of_challenge
      t.integer :amount
      t.integer :project_id

      t.timestamps
    end
  end
end
