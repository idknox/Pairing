require "spec_helper"

feature "A student asking a question" do
  scenario "a student can submit a question for a day" do
    student = create_user(cohort_id: create_cohort, email: "user@example.com")
    create_question(text: "Some question I asked a while ago?", created_at: Date.today - 3.days, cohort_id: student.cohort_id)

    sign_in(student)
    click_on "Questions"

    fill_in "Question", with: "This is a question I want answered?"
    click_on "Submit"

    expect(page).to have_content("Question added.")
    expect(page).to have_content("This is a question I want answered?")

    fill_in "Question", with: "This is another question I want answered?"
    click_on "Submit"

    expect(page).to have_content("Question added.")
    expect(page).to have_content("This is another question I want answered?")

    click_on "Questions"

    within("section", text: (Date.today - 3.days).to_s) do
      expect(page).to have_content("Some question I asked a while ago")
    end

    within("section", text: Date.today.to_s) do
      expect(page).to have_content("This is a question I want answered?")
      expect(page).to have_content("This is another question I want answered?")
    end
  end
end