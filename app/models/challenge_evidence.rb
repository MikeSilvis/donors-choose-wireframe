class ChallengeEvidence < ActiveRecord::Base
  attr_accessible :image, :challenge_id, :remote_image_url
  belongs_to :challenge
  mount_uploader :image, ImageUploader
end
