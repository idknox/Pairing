require 'spec_helper'

feature "Cohorts" do

  let!(:cohort) { create_cohort(name: 'Boulder gSchool') }
  let!(:instructor) { create_user(first_name: "Instructor", last_name: "User", github_id: '987', role_bit_mask: 1) }
  let!(:student) { create_user(first_name: "Student", last_name: "User", github_id: '123', cohort_id: cohort.id, github_username: "Student12345") }

  scenario "instructor is able to view cohorts" do
    sign_in(instructor)

    cohort = Cohort.create(name: "foobar#{rand(1000)}")

    visit '/cohorts'

    expect(page).to have_content(cohort.name)
  end

  scenario "non-instructors cannot see the cohorts path" do
    Cohort.create(name: "foobar")

    visit '/cohorts'
    expect(page.current_path).to eq(root_path)

    sign_in(student)

    visit '/cohorts'
    expect(page.current_path).to eq(root_path)
  end

  scenario "instructor can see a list of students and a link to their github repository" do
    sign_in(instructor)

    visit '/cohorts'

    click_on 'Boulder gSchool'

    expect(page).to have_content("Student User")
    expect(page).to have_link("Github")
  end
end