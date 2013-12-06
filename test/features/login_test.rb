require "test_helper"

feature "Login" do
  scenario "allows user to log in with github" do
    visit root_path
    click_on "Login"
    page.must_have_content("user@example.com")
    page.must_have_content("githubUser")
  end
end