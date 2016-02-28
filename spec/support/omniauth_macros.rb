module OmniauthMacros
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    auth_hash = {
      'provider' => 'spotify',
      'uid' => '123545',
      'info' => {
        'display_name' => 'mockuser',
        'email' => 'mockuser@mockmail.com',
        'image' => []
      },
      'credentials' => {
        'token' => 'mock_token'
      }
    }

    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new(auth_hash)
  end
end
