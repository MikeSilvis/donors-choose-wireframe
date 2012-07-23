class AddTargetFundingToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :target_funding_cents, :integer
    add_column :challenges, :target_funding, :integer
  end
end
