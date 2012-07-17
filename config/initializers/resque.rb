if Rails.env.production?
  require 'resque'
  redis_url = "redis://redistogo:246cb2c3fb7c4a3bfbf854dcab5f5800@cod.redistogo.com:10039/"
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