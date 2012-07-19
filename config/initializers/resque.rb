if Rails.env.production?
  require 'resque'
  redis_url = "redis://redistogo:1d5fe284ccd1c00cf260297db7b6447c@chubb.redistogo.com:9365/"
  uri = URI.parse(redis_url)
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  Resque.redis = REDIS
  Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
elsif Rails.env.development?
  require 'resque'
  redis_url = 'localhost:6379'
  uri = URI.parse(redis_url)
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  Resque.redis = REDIS
  Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
end