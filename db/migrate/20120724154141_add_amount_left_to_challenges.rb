class AddAmountLeftToChallenges < ActiveRecord::Migration
  def change
  	add_column :challenges, :amount_left, :integer
  end
end
