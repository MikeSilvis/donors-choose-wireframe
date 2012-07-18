class Message < ActiveRecord::Base
  IMAGE_REGEX     = /http[s]?:\/\/\S+\.(?:jpg|gif|png|jpeg)(?:\?.*)?/i
  TEXT_REGEX      = /http[s]?:\/\/\S+\.(?:com|net|org|biz|in|co|info|gov|ly|me)(?:\?.*)?/i
  VIMEO_REGEX     = /http[s]?:\/\/vimeo.com\/\d{1,}/i
  YOUTUBE_REGEX   = /http[s]?:\/\/www.youtube.com\/watch\?v=\S{1,}/i
  REGEX_HASH      = { :YOUTUBE_REGEX => YOUTUBE_REGEX, :VIMEO_REGEX => VIMEO_REGEX,
                      :IMAGE_REGEX => IMAGE_REGEX, :TEXT_REGEX => TEXT_REGEX }
  MEDIA_TYPE_HASH = { :YOUTUBE_REGEX => "video", :VIMEO_REGEX => "video",
                      :IMAGE_REGEX => "image", :TEXT_REGEX => "text" }

  before_create :check_for_media

  belongs_to :project

  attr_accessible :name, :body, :url, :media_type

  validates :name, presence: true
  validates :body, presence: true
  validates :project_id, presence: true

  def check_for_media
    REGEX_HASH.each do |key, reg|
      urls = self.body.scan(reg)
        unless urls.empty?
          self.media_type = MEDIA_TYPE_HASH[key]
          self.url        = urls.first
          break
        end
    end
  end

  def embedly_response
    if self.media_type == "video"
      api = Embedly::API.new(key: EMBEDLY_KEY)
      obj = api.oembed(url: self.url)
      obj.first
    end
  end

  def embed
    REDIS.set "message_id_#{self.id}", "#{embedly_response.html.html_safe}"
    embedly_response.html.html_safe
  end
end