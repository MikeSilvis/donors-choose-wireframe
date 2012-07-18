class ChallengeEvidence < ActiveRecord::Base
  attr_accessible :image, :challenge_id, :external_url
  belongs_to :challenge
  mount_uploader :image, ImageUploader

  def embed
    return self.display_html if self.display_html
    result = embedly_response
    # raise result.inspect
    if result.type == 'photo'
      self.display_html = "<img src='#{result.url}'>"
    elsif result.type == 'video'
      self.display_html = result.html
    end
    self.save
    self.display_html
  end

  def embedly_response
    api = Embedly::API.new(key: EMBEDLY_KEY)
    api.oembed(url: self.external_url).first
  end
end
