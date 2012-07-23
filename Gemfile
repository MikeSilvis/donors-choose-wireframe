source 'https://rubygems.org'

ruby "1.9.3"
gem 'rails', '3.2.6'
gem 'bourbon', '~> 2.1.1'
gem 'high_voltage'
gem 'donors_choose2'
gem 'hashie'
gem 'carrierwave'
gem 'rmagick'
gem 'fog'
gem 'redis-store'
gem 'resque', "~> 1.20.0", :require => 'resque/server'
gem 'resque-scheduler', :require => 'resque_scheduler'
gem 'text_to_media', github: "verdi327/text_to_media"
gem 'money-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'capybara'
  gem 'launchy'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'simplecov'
  gem 'launchy'
  gem 'vcr'
  gem 'fakeweb'
  gem 'sqlite3'
end

gem 'jquery-rails'