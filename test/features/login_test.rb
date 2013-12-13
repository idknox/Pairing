require "test_helper"

feature "Login" do
  scenario "allows user to log in with github" do
    User.create!(first_name: "Github", last_name: "User", email: "user@example.com")

    mock_omniauth

    visit root_path
    click_on "Login"

    within "#flash" do
      page.must_have_content(I18n.t("welcome_message", first_name: "Github", last_name: "User"))
    end
  end

  scenario "redirects to the root path when oauth fails" do
    OmniAuth.config.mock_auth[:github] = :invalid_credentials

    visit root_path
    click_on "Login"

    within "#flash" do
      page.must_have_content(I18n.t("login_failed"))
    end
  end
end