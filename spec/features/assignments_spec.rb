require "spec_helper"

feature "Assignments" do

  let!(:cohort) { create_cohort(name: 'Boulder gSchool') }
  let!(:instructor) { create_user(first_name: "Instructor", last_name: "User", github_id: '987', role_bit_mask: 1) }
  let!(:student) { create_user(first_name: "Student", last_name: "User", github_id: '123', cohort_id: cohort.id, github_username: "Student12345") }

  scenario "instructor is able to create assignments" do
    sign_in(instructor)

    visit '/instructor_dashboard'

    click_on 'Create Assignment'

    fill_in 'Name', with: 'Bunch of array'
    fill_in 'GitHub Repo', with: 'http://example.com/repo'
    click_on 'Add Assignment'

    expect(page).to have_content 'Assignment successfully created'
  end
end
