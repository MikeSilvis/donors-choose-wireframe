class ChallengeEvidence < ActiveRecord::Base
  attr_accessible :image, :challenge_id
  belongs_to :challenge
end
