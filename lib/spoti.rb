require 'rspotify'

class Spoti
  def self.credentials
    @credentials ||= Rails.application.config_for(:spotify)
  rescue RuntimeError => e
    raise RuntimeError.new('You need to set your own Spotify credentials. See the README for more info')
  end
end
