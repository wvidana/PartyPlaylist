# config/initializers/omniauth.rb

require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, Rails.application.secrets.spoti_id, Rails.application.secrets.spoti_secret, scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end
