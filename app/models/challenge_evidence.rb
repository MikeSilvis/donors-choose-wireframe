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
    case embedly_response.type
      when 'photo' then "<img src='#{embedly_response.url}'>"
      when 'video' then embedly_response.html
      else "<img src='/assets/images/no_pic.jpeg'"
    end
  end

  def embedly_response
    api = Embedly::API.new(key: EMBEDLY_KEY)
    @embedly ||= api.oembed(url: self.external_url).first
  end
end