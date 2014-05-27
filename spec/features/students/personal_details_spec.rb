require "spec_helper"

feature "Student adding personal details" do
  scenario "a student cant add personal details to their account" do
    @cohort = create_cohort(name: "Cohort Name",
                            google_maps_location: "this is a google map url",
                            directions: '<p>The classroom is on the right</p><p>This is some more text</p>')
    create_user(first_name: "Jeff", last_name: "Taggart", email: "user@example.com", cohort: @cohort)
    mock_omniauth

    visit root_path
    click_on I18n.t("nav.sign_in")
    click_on "Personal Info"

    fill_in "Location", with: "Denver"
    fill_in "Phone", with: "303-910-5555"
    fill_in "Twitter", with: "jetaggart"
    fill_in "Blog", with: "someblog.com"

    click_on "Save"
    expect(page).to have_content("Personal information was successfully updated")

    click_on "Personal Info"

    expect(find_field("Location").value).to eq("Denver")
    expect(find_field("Phone").value).to eq("303-910-5555")
    expect(find_field("Twitter").value).to eq("jetaggart")
    expect(find_field("Blog").value).to eq("someblog.com")
  end

  scenario "an instructor can see student information" do
    @cohort = create_cohort(name: "Cohort Name",
                            google_maps_location: "this is a google map url",
                            directions: '<p>The classroom is on the right</p><p>This is some more text</p>')
    create_user(first_name: "Jeff",
                last_name: "Taggart",
                email: "user@example.com",
                location: "Some location",
                phone: "303-111-1111",
                twitter: "twitter_handle",
                blog: "blog.com",
                cohort: @cohort)

    create_user(first_name: "Instructor", last_name: "User", email: "admin@example.com", cohort: @cohort, role_bit_mask: User::INSTRUCTOR)

    mock_omniauth(info_overrides: {email: "admin@example.com"})

    visit "/"
    click_on I18n.t("nav.sign_in")
    visit cohort_path(@cohort)

    click_on "Jeff Taggart"

    expect(page).to have_content("Jeff Taggart")
    expect(page).to have_content("user@example.com")
    expect(page).to have_content("Some location")
    expect(page).to have_content("303-111-1111")
    expect(page).to have_content("twitter_handle")
    expect(page).to have_content("blog.com")
  end
end