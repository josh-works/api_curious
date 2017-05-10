require 'rails_helper'

RSpec.feature "user can authenticate application" do
  scenario "from home page, user can log in" do
    visit root_path

    expect(page).to have_link "Login with Github"
  end

  scenario "after logging in, user sent to dashboard" do

    visit root_path
    click_on("Login with Github")

    expect(path).to be(dashboard_path)
  end
end

#
# require 'rails_helper'
#
# RSpec.feature 'User can log in w/ Slack' do
#   context 'An existing user has valid credentials' do
#
#     before do
#       Capybara.app = Poodr::Application
#       stub_oauth
#     end
#
#     def stub_oauth
#       OmniAuth.config.test_mode = true
#
#       OmniAuth.config.mock_auth[:slack] = OmniAuth::AuthHash.new({
#                                            provider: 'slack',
#                                            uid: '1234',
#                                            info: {
#                                             user: 'POODR'
#                                            },
#                                            credentials: {
#                                              token: 'lasagna'
#                                            }
#       })
#     end
#
#     scenario 'The user clicks login on root path' do
#       visit '/'
#
#       expect(page.status_code).to eq 200
#
#       click_link 'slack-login-btn'
#
#       expect(current_path).to eq user_path(User.last)
#
#       expect(page.body).to have_content 'Welcome, POODR!'
#       expect(page.body).to have_link 'Logout'
#     end
#   end
# end


# # in test/integration/user_logs_in_with_twitter_test.rb
# require "test_helper"
# class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
#   include Capybara::DSL
#   def setup
#     Capybara.app = OauthWorkshop::Application
#   end
#
#   test "logging in" do
#     visit "/"
#     assert_equal 200, page.status_code
#     click_link "Sign in with Twitter"
#     assert_equal "/", current_path
#     assert page.has_content?("Horace")
#     assert page.has_link?("Logout")
#   end
# end

#
# require "test_helper"
# class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
#   include Capybara::DSL
#   def setup
#     Capybara.app = Storedom::Application
#     stub_omniauth
#   end
#
#   test "logging in" do
#     visit "/"
#     assert_equal 200, page.status_code
#     click_link "login"
#     assert_equal "/", current_path
#     assert page.has_content?("Horace")
#     assert page.has_link?("logout")
#   end
#
#   def stub_omniauth
#     # first, set OmniAuth to run in test mode
#     OmniAuth.config.test_mode = true
#     # then, provide a set of fake oauth data that
#     # omniauth will use when a user tries to authenticate:
#     OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
#       provider: 'twitter',
#       extra: {
#         raw_info: {
#           uid: "1234",
#           name: "Horace",
#           screen_name: "worace",
#         }
#       },
#       credentials: {
#         token: "pizza",
#         secret: "secretpizza"
#       }
#     })
#   end
# end
