class Message < ActiveRecord::Base
  IMAGE_REGEX     = /http[s]?:\/\/\S+\.(?:jpg|gif|png|jpeg)(?:\?.*)?/i
  LINK_REGEX      = /http[s]?:\/\/\S+\.(?:com|net|org|biz|in|co|info|gov|ly|me|im)(?:\?.*)?/i
  VIMEO_REGEX     = /http[s]?:\/\/vimeo.com\/\d{1,}/i
  YOUTUBE_REGEX   = /http[s]?:\/\/www.youtube.com\/watch\?v=\S{1,}/i
  REGEX_HASH      = { :YOUTUBE_REGEX => YOUTUBE_REGEX, :VIMEO_REGEX => VIMEO_REGEX,
                      :IMAGE_REGEX => IMAGE_REGEX, :TEXT_REGEX => LINK_REGEX }
  MEDIA_TYPE_HASH = { :YOUTUBE_REGEX => "video", :VIMEO_REGEX => "video",
                      :IMAGE_REGEX => "image", :TEXT_REGEX => "link" }

  before_create :check_for_media

  belongs_to :project

  attr_accessible :name, :body, :url, :media_type, :video_html, :project_id

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

  # Queries the Embedly API for an HTML embed string if the message content is a video
  #
  # @example embedly_response for a video message
  #   message = Message.create(:project_id => 1,
  #                            :body => "http://www.youtube.com/watch?v=Mw7iVr5rWQE&feature=g-logo-xit",
  #                            :name => "worace")
  #   message.embedly_response #=> <Embedly::EmbedlyObject>
  #
  # @return [Embedly::EmbedlyObject] An Embedly Object containing data about the referenced media
  def embedly_response
    if self.media_type == "video"
      api = Embedly::API.new(key: EMBEDLY_KEY)
      obj = api.oembed(url: self.url)
      obj.first
    end
  end


  # Returns the HTML string necessary for embedding the object
  #
  # @example
  #   message = Message.create(:project_id => 1,
  #                            :body => "http://www.youtube.com/watch?v=Mw7iVr5rWQE&feature=g-logo-xit",
  #                            :name => "worace")
  #   message.embed #=> "<iframe width=\"640\" height=\"360\" src=\"http://www.youtube.com/embed/Mw7iVr5rWQE?fs=1&feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>"
  #
  # @return [String] An HTML string with the iframe needed for embedding the object
  def embed
    response = embedly_response.html
    if response
      self.video_html = response
      self.save
    else
      "No Video Available"
    end
      self.video_html
  end
end
