class ChallengeEvidence < ActiveRecord::Base
  attr_accessible :image, :challenge_id, :external_url, :display_html
  belongs_to :challenge
  belongs_to :user

  mount_uploader :image, ImageUploader

  def embed
    display_html || update_from_embedly
  end

  def update_from_embedly
    update_attributes(display_html: display_html_from_embedly)
    display_html
  end

  def display_html_from_embedly
    result = embedly_response
    if result
      send("update_for_#{result.type}", result)
    else
      "<img src='/assets/images/no_pic.jpeg'"
    end
  end

  def update_for_video(result)
    result.html
  end

  def update_for_photo(result)
    "<img src='#{result.url}'>"
  end

  def embedly_response
    api = Embedly::API.new(key: EMBEDLY_KEY)
    api.oembed(url: self.external_url).first
  end
end