require 'rails_helper'

RSpec.configure do |config|
  config.include OmniauthMacros
end

OmniAuth.config.test_mode = true

RSpec.describe UsersController, :type => :controller do

  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    mock_auth_hash
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:spotify]
    # binding.pry
  end

  describe "GET #spotify" do
    it "responds successfully with an HTTP 200 status code" do
      get :spotify
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the spotify template" do
      get :spotify
      expect(response).to render_template("spotify")
    end
  end
end