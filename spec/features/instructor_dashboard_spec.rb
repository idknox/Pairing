require "spec_helper"

feature "Instructor dashboard" do

  let!(:cohort) { create_cohort(name: 'Boulder gSchool') }
  let!(:instructor) { create_user(first_name: "Instructor", last_name: "User", github_id: '987', role_bit_mask: 1) }
  let!(:student) { create_user(first_name: "Student", last_name: "User", github_id: '123', cohort_id: cohort.id, github_username: "Student12345") }

  scenario "instructor is able to view the dashboard" do
    sign_in(instructor)

    visit '/instructor_dashboard'

    expect(page).to have_content(cohort.name)
  end

  scenario "non-instructors cannot see the instructor dashboard" do
    visit '/instructor_dashboard'
    expect(page.current_path).to eq(root_path)

    sign_in(student)

    visit '/instructor_dashboard'
    expect(page.current_path).to eq(root_path)
  end
end
