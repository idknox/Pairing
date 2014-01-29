require "spec_helper"

feature "Feedback" do
  scenario "allows logged in student to give feedback to another student" do
    cohort = Cohort.create!(name: "March gSchool")
    User.create!(first_name: "Giving Feedback", last_name: "Student", email: "givingFeedback@example.com", cohort_id: cohort.id, github_id: "1234")
    User.create!(first_name: "Receiving Feedback", last_name: "Student", email: "receivingFeedback@example.com", cohort_id: cohort.id, github_id: "9876")

    mock_omniauth(base_overrides: {uid: "1234"})

    visit root_path

    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.feedback')
    click_on I18n.t('feedback.give')

    select "Receiving Feedback Student", from: "feedback_entry[recipient_id]"
    fill_in "feedback_entry[comment]", with: "This person did a great job of explaining Minitest::Spec."

    click_on I18n.t('submit')

    within "#flash" do
      expect(page).to have_content I18n.t('feedback.success')
    end

    click_on I18n.t('nav.sign_out')

    mock_omniauth(base_overrides: {uid: "9876"})

    visit root_path

    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.feedback')


    expect(page).to have_content "Giving Feedback"

    page.find('.feedback-entries td a').click

    expect(page).to have_content "This person did a great job of explaining Minitest::Spec."
  end
end