require "test_helper"

feature "Login" do
  scenario "allows user to log in with github" do
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        {
            provider: 'github',
            uid: '123545',
            info: {
                email: 'user@example.com',
                nickname: 'githubUser'
            }

        }
    )

    visit root_path
    click_on "Login"
    page.must_have_content("user@example.com")
    page.must_have_content("githubUser")
  end

  scenario "redirects to the root path when oauth fails" do
    OmniAuth.config.mock_auth[:github] = :invalid_credentials

    visit root_path
    click_on "Login"
    page.current_url.must_equal 'http://www.example.com/'
  end
end