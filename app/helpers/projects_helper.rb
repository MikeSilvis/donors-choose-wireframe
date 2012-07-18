module ProjectsHelper
  #Properly displays the message based on its media_type
  #
  # @param [Message]
  # @return [String] the html representation of a message
  def format_message(message)
    unless message.nil?
      case message.media_type
      when "video"
        get_video(message)
      when "link"
        link_to(message.url, message.url, target: "_blank")
      when "image"
        image_tag(message.url)
      else
        message.body
      end
    end
  end

  #Returns the html safe markup for the video_html attribute if it exists.
  #If no attribute exist, it triggers a call to embedly to fetch markup
  #
  # @param [Message]
  # @return [String] the html markup for a message with a video media_type
  def get_video(message)
    if message.video_html
      message.video_html.html_safe
    else
      message.embed.html_safe
    end
  end
end
