require 'rails_helper'

RSpec.feature "user can authenticate application" do
  before :each do
    stub_oauth
  end

  describe "from home page" do
    it "sees login button" do
      visit root_path
      expect(page).to have_link "Sign in with Github"
    end
  end

  describe "and after logging in" do
    it "sees user's name" do
      visit root_path
      click_on("Sign in with Github")

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Josh Thompson")
    end
  end

  def stub_oauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
     "provider"=>"github",
     "uid"=>"5198260",
     "info"=>
      {"nickname"=>"josh-works",
       "email"=>nil,
       "name"=>"Josh Thompson",
       "image"=>"https://avatars2.githubusercontent.com/u/5198260?v=3",
       "urls"=>{"GitHub"=>"https://github.com/josh-works", "Blog"=>"http://josh.works"}},
     "credentials"=>{"token"=>"nanananananana", "expires"=>false},
     "extra"=>
      {"raw_info"=>
        {"login"=>"josh-works",
         "id"=>5198260,
         "name"=>"Josh Thompson",
         "company"=>"@turingschool",
         "blog"=>"http://josh.works",
         "created_at"=>"2013-08-09T15:29:59Z",
         "updated_at"=>"2017-05-01T22:59:46Z"},
         "all_emails"=>[]}
         })
  end
end
