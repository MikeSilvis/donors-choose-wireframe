module ProjectsHelper
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

  def get_video(message)
    if message.video_html
      message.video_html.html_safe
    else
      message.embed.html_safe
    end
  end
end
