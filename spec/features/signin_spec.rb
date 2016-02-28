require 'omniauth_helper'

RSpec.feature 'Sign In' do
  before do
    Capybara.current_driver = :selenium
    mock_auth_hash
  end

  it "Signs in with spotify" do
    visit '/'

    click_link 'Sign in with Spotify'

    expect(page).to have_text('Successfully authenticated from Spotify account')
  end
end
