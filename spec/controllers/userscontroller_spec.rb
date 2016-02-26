require 'omniauth_helper'

RSpec.describe UsersController, :type => :controller do

  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    mock_auth_hash
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:spotify]
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the spotify template" do
      get :show
      expect(response).to render_template("spotify")
    end
  end
end
