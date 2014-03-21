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

  scenario 'allows student to create a new job opportunity' do
    cohort = Cohort.create!(name: "March gSchool")
    create_user(first_name: "Student", cohort_id: cohort.id, github_id: "1234")

    mock_omniauth(base_overrides: {uid: "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')

    click_link 'New Job Opportunity'
    fill_in(:job_opportunity_company_name, with: 'Pivotal Labs')
    fill_in(:job_opportunity_company_location, with: 'San Francisco, CA')
    fill_in(:job_opportunity_contact_name, with: 'Miriam Fisher')
    fill_in(:job_opportunity_contact_email, with: 'miriam@example.com')
    fill_in(:job_opportunity_contact_number, with: '303-222-7500')
    select('Interviewing', from: :job_opportunity_job_status)
    select('Accepted', from: :job_opportunity_decision)
    fill_in(:job_opportunity_salary, with: '$68,000')
    fill_in(:job_opportunity_job_title, with: 'Junior Developer')

    click_button 'Submit'
    expect(page).to have_content('Job Opportunity Successfully Created')
    expect(page).to have_content('Pivotal Labs')
  end
end