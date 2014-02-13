require 'spec_helper'

feature "Cohorts" do

  let(:instructor) { create_user(first_name: "Github", last_name: "User", github_id: '123', role_bit_mask: 1) }
  let(:student) { create_user(first_name: "Github", last_name: "User", github_id: '123') }

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

end