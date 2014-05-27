require "spec_helper"

feature "A student viewing their dashboard" do
  before do
    @cohort = create_cohort(name: "Cohort Name",
                           google_maps_location: "this is a google map url",
                           directions: '<p>The classroom is on the right</p><p>This is some more text</p>')
    create_user(first_name: "Jeff", last_name: "Taggart", email: "user@example.com", cohort: @cohort)
    mock_omniauth

    visit root_path
    click_on I18n.t("nav.sign_in")
  end

  scenario "getting info about class and preparation" do
    click_on "Info"

    expect(find("#google_map_location")["src"]).to eq("this is a google map url")

    expect(page).to have_content('The classroom is on the right')
    expect(page).to have_content('This is some more text')

    expect(page).to have_no_content('<p>This is some more text</p>')
  end

  scenario "allows a student to submit an exercise" do
    CohortExercise.create!(
      cohort_id: @cohort.id,
      exercise_id: create_exercise(name: "Arrays and things").id
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
      cohort_id: @cohort.id,
      exercise_id: create_exercise(name: "Arrays and things").id
    )

    click_on "Cohort"
    click_on "Exercises"

    expect(page).to have_content("Arrays and things")
  end
end
