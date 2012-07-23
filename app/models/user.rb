class User < ActiveRecord::Base

  def self.find_or_create_from_auth(auth)
    user = find_by_provider_and_uid(auth.provider, auth.uid) || User.send("create_from_#{auth.provider}", auth)
  end

  def self.create_from_twitter(auth)
    user = User.new
    user.provider = auth.provider
    user.uid = auth.uid
    user.screen_name = auth.extra.raw_info.screen_name
    user.profile_image_url = auth.extra.raw_info.profile_image_url
    user.save
    return user
  end
end
