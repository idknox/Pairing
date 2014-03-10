require 'spec_helper'

feature 'Job Opportunities' do
  scenario 'allows student to view their employment dashboard' do
    cohort = Cohort.create!(name: "March gSchool")
    create_user(first_name: "Student", cohort_id: cohort.id, github_id: "1234")

    mock_omniauth(base_overrides: {uid: "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')

    expect(page).to have_content "My Job Dashboard"
  end
end