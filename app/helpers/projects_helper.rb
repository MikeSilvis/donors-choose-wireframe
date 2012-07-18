module ProjectsHelper
  def format_message(message)
    unless message.nil?
      case message.media_type
      when "video"
        REDIS.get "message_id_#{message.id}" || message.embed
      when "text"
        link_to(message.url, message.url, target: "_blank")
      when "image"
        image_tag(message.url)
      else
        message.body
      end
    end
  end
end
