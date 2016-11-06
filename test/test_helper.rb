ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
end

def login(h = {  })
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = nil
  @oauth_hash = OmniAuth::AuthHash.new({
                                         provider: 'twitter', uid: '12345', info: { nickname: 'すいている', image: 'http://example.com/image.jpg' }
                                       })
  OmniAuth.config.mock_auth[:twitter] = @oauth_hash
  if h[:cap]
    visit '/auth/twitter'
  else
    get '/auth/twitter'
    follow_redirect!
  end
end
