require "spec_helper"

feature "Assignments" do

  let!(:cohort) { create_cohort(name: "Boulder gSchool") }
  let!(:instructor) { create_user(first_name: "Instructor", last_name: "User", github_id: "987", role_bit_mask: 1) }
  let!(:student) { create_user(first_name: "Student", last_name: "User", github_id: "123", cohort_id: cohort.id, github_username: "Student12345") }

  before do
    sign_in(instructor)
  end

  scenario "instructor is able to create assignments" do
    visit "/instructor_dashboard"

    click_on "Create Assignment"

    fill_in "Name", with: "Bunch of array"
    fill_in "GitHub Repo", with: "http://example.com/repo"
    click_on "Add Assignment"

    expect(page).to have_content "Assignment successfully created"
  end

  scenario "instructor can assign an assignment to a cohort" do
    create_assignment(name: "Nested Hashes")

    visit "/instructor_dashboard"

    click_link cohort.name
    click_link "Assignments"
    click_link "New Assignment"

    select "Nested Hashes"
    click_button "Add Assignment"

    expect(page).to have_content "Assignment successfully added to cohort"
    expect(page).to have_content "Nested Hashes"
  end

  scenario "instructor can view who has and has not completed an assignment" do
    create_user(first_name: "Joe", last_name: "Mama", cohort_id: cohort.id)

    assignment = create_assignment(name: "Nested Hashes")
    cohort.update!(assignments: [assignment])
    create_submission(assignment: assignment,
                      user: student,
                      github_repo_name: "some_repo_name")

    visit "/instructor_dashboard"
    click_link cohort.name
    click_link "Assignments"
    click_link assignment.name

    expect(page).to have_content assignment.name

    within("section", text: "Completed Submissions") do
      expect(find("a")["href"]).to eq("https://github.com/Student12345/some_repo_name")
      end

    within("section", text: "Students Without Submissions") do
      expect(page).to have_content("Joe Mama")
    end
  end
end
