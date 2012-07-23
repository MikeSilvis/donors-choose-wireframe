require 'resque'
if Rails.env.production?
  redis_url = "redis://redistogo:1a997ec7ce05b6dcafcd7929bbd46c9e@chubb.redistogo.com:9405"
  uri = URI.parse(redis_url)
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  REDIS = Redis.new
end
Resque.redis = REDIS
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
