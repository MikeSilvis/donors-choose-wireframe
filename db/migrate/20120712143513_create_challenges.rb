class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name_of_challenger
      t.string :title_of_challenge
      t.integer :minimum_amount
      t.integer :maximum_amount
      t.integer :project_id

      t.timestamps
    end
  end
end
