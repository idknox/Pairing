require "test_helper"

feature "Login" do
  scenario "allows user to log in with github and log out" do
    User.create!(first_name: "Github", last_name: "User", email: "user@example.com")

    mock_omniauth

    visit root_path
    click_on I18n.t('sign_in')

    within "#flash" do
      page.must_have_content(I18n.t("welcome_message", first_name: "Github", last_name: "User"))
    end

    page.must_have_content('Instructors')

    click_on I18n.t('sign_out')

    page.must_have_link(I18n.t('sign_in'))
  end

  scenario "displays a unauthorized message if the user does not have a record in the db" do
    mock_omniauth

    visit root_path
    click_on I18n.t('sign_in')

    within "#flash" do
      page.must_have_content(I18n.t("access_denied"))
    end
  end

  scenario "redirects to the root path when oauth fails" do
    OmniAuth.config.mock_auth[:github] = :invalid_credentials

    visit root_path
    click_on I18n.t('sign_in')

    within "#flash" do
      page.must_have_content(I18n.t("login_failed"))
    end
  end
end