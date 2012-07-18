module ProjectsHelper
  def format_message(message)
    case message.media_type
    when "video"
      message.embed
    when "text"
      link_to(message.url, message.url, target: "_blank")
    when "image"
      image_tag(message.url)
    else
      message.body
    end
  end
end
