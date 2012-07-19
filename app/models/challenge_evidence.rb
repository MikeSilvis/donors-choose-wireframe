class ChallengeEvidence < ActiveRecord::Base
  attr_accessible :image, :challenge_id, :external_url
  belongs_to :challenge
  mount_uploader :image, ImageUploader

  def embed
    return self.display_html if self.display_html

    if self.image.file
      self.display_html = "<img src='#{self.image_url}'>"
    else
      self.display_html = display_html_from_embedly
    end
    self.save
    self.display_html
  end

  def display_html_from_embedly
    result = embedly_response
    if result.type == 'photo'
      "<img src='#{result.url}'>"
    elsif result.type == 'video'
      result.html
    else
      "<img src='http://www.insidegatlinburg.com/wp-content/RainbowTrout_MendLess_2.jpg'"
    end
  end

  def embedly_response
    api = Embedly::API.new(key: EMBEDLY_KEY)
    api.oembed(url: self.external_url).first
  end
end
