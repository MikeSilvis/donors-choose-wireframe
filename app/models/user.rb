class User < ActiveRecord::Base
  # attr_accessible :title, :body
  def self.find_or_create_from_auth(auth)
    unless user = find_by_provider_and_uid(auth.provider, auth.uid)
      user = User.new
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.extra.raw_info.screen_name
      user.save
    end
    user
  end
end
