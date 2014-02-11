module FeatureHelpers

  def sign_in(user)
    mock_omniauth(base_overrides: { uid: user.github_id })

    visit root_path
    click_on I18n.t('nav.sign_in')
  end

end