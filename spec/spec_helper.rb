require 'simplecov'
SimpleCov.start 'rails'

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'
SimpleCov.start
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'vcr_setup'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_base_class_for_anonymous_controllers = false

  config.include UserSupport
end

module Capybara
  class Session
    def has_image?(src)
      has_xpath?("//img[contains(@src,\"#{src}\")]")
    end
  end
end

class UploadStubber
  def self.build_upload_evidence(challenge)
    evidence = FactoryGirl.build(:challenge_evidence, challenge_id: challenge.id)
    image = ImageUploader.new
    image.stub(:file).and_return(true)
    image.stub(:url).and_return("http://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Salmo_trutta.jpg/220px-Salmo_trutta.jpg")
    evidence.stub(:image).and_return(image)
    evidence.stub(:image_url).and_return("http://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Salmo_trutta.jpg/220px-Salmo_trutta.jpg")
    evidence.save
    evidence
  end
end


OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new( {
  provider: "twitter",
  :uid => '123545',
  :extra => { :raw_info => { :screen_name => "Nisarg" } }
})
