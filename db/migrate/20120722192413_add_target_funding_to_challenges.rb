class AddTargetFundingToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :target_funding_cents, :integer
  end
end
