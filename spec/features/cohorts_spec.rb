require 'spec_helper'

feature "Cohorts" do

  let!(:cohort) { create_cohort(name: 'Boulder gSchool') }
  let!(:instructor) { create_user(first_name: "Instructor", last_name: "User", github_id: '987', role_bit_mask: 1) }
  let!(:student) { create_user(first_name: "Student", last_name: "User", github_id: '123', cohort_id: cohort.id, github_username: "Student12345") }

  scenario "instructor is able to view cohorts" do
    sign_in(instructor)

    cohort = create_cohort(name: "foobar#{rand(1000)}")

    visit '/cohorts'

    expect(page).to have_content(cohort.name)
  end

  scenario "non-instructors cannot see the cohorts path" do
    create_cohort(name: "foobar")

    visit '/cohorts'
    expect(page.current_path).to eq(root_path)

    sign_in(student)

    visit '/cohorts'
    expect(page.current_path).to eq(root_path)
  end


  scenario "instructor can add student to cohort" do
    sign_in(instructor)

    visit '/cohorts'

    click_on 'Boulder gSchool'
    click_on 'Add Student'

    fill_in 'First name', :with => 'John'
    fill_in 'Last name', :with => 'Johnson'
    fill_in 'Email', :with => 'john@johnny.com'

    click_on 'Add Student'

    expect(page).to have_content('Student added succesfully')
    expect(page).to have_content('Manage Boulder gSchool')
    expect(page).to have_content('John Johnson')
    expect(page).to have_content('john@johnny.com')
  end

  scenario "it shows errors on the add student form" do
    sign_in(instructor)

    visit '/cohorts'

    click_on 'Boulder gSchool'
    click_on 'Add Student'

    click_on 'Add Student'

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
  end

  scenario "instructor can see a list of students and a link to their github repository" do
    sign_in(instructor)

    visit '/cohorts'

    click_on 'Boulder gSchool'

    expect(page).to have_content("Student User")
    expect(page).to have_link("Github")
  end

  scenario "instructors can see a one-on-one schedule" do
    instructor = create_user(first_name: "Teacher", last_name: "User", github_id: '1010', role_bit_mask: 1)
    student = create_user(first_name: "Student", last_name: "User", github_id: '1111', cohort_id: cohort.id, github_username: "Student12345")

    sign_in(instructor)

    visit '/cohorts'
    click_on cohort.name
    click_on 'Generate One-on-one schedule'

    expect(page).to have_content("Student User")
    expect(page).to have_content("Teacher User")
    expect(page).to have_content("1pm")
  end

  scenario "instructors enter rank for each students" do
    instructor = create_user(first_name: "Teacher", last_name: "User", github_id: '1010', role_bit_mask: 1)
    student = create_user(first_name: "First", last_name: "Student", github_id: '1111', cohort_id: cohort.id, github_username: "Student12345")
    student2 = create_user(first_name: "Last", last_name: "Student", github_id: '2222', cohort_id: cohort.id, github_username: "Student2222")

    sign_in(instructor)

    visit '/cohorts'
    click_on cohort.name
    click_on 'Enter Rankings'

    expect(page).to have_content(student.full_name)
    expect(page).to have_content(student2.full_name)

    fill_in "student_#{student.id}_rank", with: "100"
    fill_in "student_#{student2.id}_rank", with: "37"
    click_on "Save Rankings"

    expect(page).to have_content("Rankings were saved")
  end
end
