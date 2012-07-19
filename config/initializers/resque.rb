if Rails.env.production?
  require 'resque'
  redis_url = "redis://redistogo:977b137d16dedfbf0a1920b53f6788fe@chubb.redistogo.com:9365/"
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