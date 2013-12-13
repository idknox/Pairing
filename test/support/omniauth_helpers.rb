module OmniauthHelpers
  def mock_omniauth(overrides = {})
    info_defaults = {
        email: 'user@example.com',
        nickname: 'nickname'
    }

    defaults = {
        provider: 'github',
        uid: '123545',
        info: info_defaults.merge(overrides)

    }
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(defaults)
  end
end