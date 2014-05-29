require "spec_helper"

feature "Exercises" do

  let!(:cohort) { create_cohort(name: "Boulder gSchool") }
  let!(:instructor) { create_user(first_name: "Instructor", last_name: "User", github_id: "987", role_bit_mask: 1) }
  let!(:student) { create_user(first_name: "Student", last_name: "User", github_id: "123", cohort_id: cohort.id, github_username: "Student12345") }

  before do
    sign_in(instructor)
  end

  scenario "instructor is able to create and edit exercises" do
    visit "/instructor/dashboard"

    click_on "Create Exercise"

    fill_in "Name", with: "Bunch of array"
    fill_in "GitHub Repo", with: "http://example.com/repo"
    click_on "Add Exercise"

    expect(page).to have_content "Exercise successfully created"

    click_link "Bunch of array"
    click_link "Edit"

    fill_in "Name", with: "Bunch of Hashes"
    fill_in "GitHub Repo", with: "http://exemple.com/hash_repo"
    click_on "Update Exercise"

    expect(page).to have_content "Exercise successfully created"
  end

  scenario "instructor can assign an exercise to a cohort" do
    create_exercise(name: "Nested Hashes")

    visit "/instructor/dashboard"

    click_link cohort.name
    click_link "Exercises"
    click_link "Assign Exercise"

    select "Nested Hashes"
    click_button "Add Exercise"

    expect(page).to have_content "Exercise successfully added to cohort"
    expect(page).to have_content "Nested Hashes"
  end

  scenario "instructor can view who has and has not completed an exercise" do
    create_user(first_name: "Joe", last_name: "Mama", cohort_id: cohort.id)

    exercise = create_exercise(name: "Nested Hashes")
    cohort.update!(exercises: [exercise])
    create_submission(exercise: exercise,
                      user: student,
                      github_repo_name: "some_repo_name")

    visit "/instructor/dashboard"
    click_link cohort.name
    click_link "Exercises"
    click_link exercise.name

    expect(page).to have_content exercise.name

    within("section", text: "Completed Submissions") do
      expect(find("a")["href"]).to eq("https://github.com/Student12345/some_repo_name")
      end

    within("section", text: "Students Without Submissions") do
      expect(page).to have_content("Joe Mama")
    end
  end

  scenario "instructor can view what exercises a student has completed" do
    exercise_1 = create_exercise(name: "Nested Hashes")
    exercise_2 = create_exercise(name: "Arrays")

    cohort.update!(exercises: [exercise_1, exercise_2])

    create_submission(exercise: exercise_1,
                      user: student,
                      github_repo_name: "some_repo_name")


    visit "/instructor/dashboard"
    click_on cohort.name
    click_on "Student User"

    within(".exercises", text: "Completed Exercises") do
      expect(page).to have_content("Nested Hashes")
    end

    within(".exercises", text: "Incomplete Exercises") do
      expect(page).to have_content("Arrays")
    end
  end
end
