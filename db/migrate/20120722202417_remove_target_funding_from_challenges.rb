class RemoveTargetFundingFromChallenges < ActiveRecord::Migration
  def change
    remove_column :challenges, :target_funding
  end
end
