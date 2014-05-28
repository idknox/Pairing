require "spec_helper"

feature "Student Exercises" do
  before do
    @cohort = create_cohort(name: "Cohort Name",
                            google_maps_location: "this is a google map url",
                            directions: '<p>The classroom is on the right</p><p>This is some more text</p>')
    create_user(first_name: "Jeff", last_name: "Taggart", email: "user@example.com", cohort: @cohort)
    mock_omniauth

    visit root_path
    click_on I18n.t("nav.sign_in")
  end

  scenario "allows a student to submit an exercise" do
    CohortExercise.create!(
      cohort: @cohort,
      exercise: create_exercise(name: "Arrays and things")
    )

    click_on "Exercises"

    within("li", text: "Arrays and things") do
      expect(page).to have_content("incomplete")
      click_on "Submit Code"
    end

    fill_in "GitHub Repo Name", with: "some_completed_exercise"
    click_on "Submit"

    expect(page).to have_content("Your code has been submitted")

    within("li", text: "Arrays and things") do
      expect(page).to have_content("completed")
    end
  end

  scenario "lists all exercises for the students cohort" do
    CohortExercise.create!(
      cohort: @cohort,
      exercise: create_exercise(name: "Arrays and things")
    )

    CohortExercise.create!(
      cohort: @cohort,
      exercise: create_exercise(name: "Another exercise")
    )

    CohortExercise.create!(
      cohort: create_cohort,
      exercise: create_exercise(name: "Shouldn't be there")
    )

    click_on "Cohort"
    click_on "Exercises"

    expect(page).to have_content("Arrays and things")
    expect(page).to have_content("Another exercise")
    expect(page).to have_no_content("Shouldn't be there")
  end
end
