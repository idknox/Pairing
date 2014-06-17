require 'rails_helper'

feature 'Job Opportunities' do
  let!(:cohort) { create_cohort(name: 'Boulder gSchool') }
  let!(:instructor) { create_user(first_name: "Instructor", last_name: "User", github_id: '987', role_bit_mask: 1, cohort_id: cohort.id) }
  scenario 'allows student to view the gSchool employment page' do
    cohort = create_cohort(name: "March gSchool")
    create_user(first_name: "Student", cohort_id: cohort.id, github_id: "1234")

    mock_omniauth(base_overrides: {uid: "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')

    expect(page).to have_content "gSchool Employment"
    expect(page).to have_content "Available Jobs to Apply to"
  end

  scenario 'allows student to add a new job opportunity' do
    cohort = create_cohort(name: "March gSchool")
    create_user(first_name: "Student", cohort_id: cohort.id, github_id: "1234")

    mock_omniauth(base_overrides: {uid: "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')

    create_job_opportunity

    expect(page).to have_content('Job Opportunity Successfully Created')
    expect(page).to have_content('Pivotal Labs')
  end

  scenario 'allows student to view their added jobs on their employment dashboard' do
    cohort = create_cohort(name: "March gSchool")
    create_user(first_name: "Student", cohort_id: cohort.id, github_id: "1234")

    mock_omniauth(base_overrides: {uid: "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')
    create_job_opportunity
    click_on 'Add Job'
    click_on 'View My Dashboard'

    expect(page).to have_content 'My Job Dashboard'
    expect(page).to have_content 'Pivotal Labs'
  end

  scenario 'allows an instructor to view the admin dashboard for employment' do
    sign_in(instructor)

    visit root_path
    click_on I18n.t('nav.job_opportunity')
    create_job_opportunity
    click_on "Admin Dashboard"

    expect(page).to have_content 'Admin Job Dashboard'
    click_link 'Pivotal Labs'
  end
  # RSpec 3 has some weird new rules for pending

  # it 'allows student to delete their job opportunities' do
  #   cohort = create_cohort(name: "March gSchool")
  #   create_user(first_name: "Student", cohort_id: cohort.id, github_id: "1234")
  #
  #   mock_omniauth(base_overrides: {uid: "1234"})
  #
  #   visit root_path
  #   click_on I18n.t('nav.sign_in')
  #   click_on I18n.t('nav.job_opportunity')
  #
  #   create_job_opportunity
  #
  #   click_link 'Pivotal Labs'
  #   expect(page).to have_content('Pivotal Labs')
  #   click_link 'Delete Job'
  #   expect(page).not_to have_content('Pivotal Labs')
  # end

  # it 'allows student to edit their job opportunities' do
  #   cohort = create_cohort(name: "March gSchool")
  #   create_user(first_name: "Student", cohort_id: cohort.id, github_id: "1234")
  #
  #   mock_omniauth(base_overrides: {uid: "1234"})
  #
  #   visit root_path
  #   click_on I18n.t('nav.sign_in')
  #   click_on I18n.t('nav.job_opportunity')
  #
  #   create_job_opportunity
  #
  #   click_link 'Pivotal Labs'
  #   click_link 'Edit Job'
  #   fill_in(:job_opportunity_company_name, with: 'Viget Labs')
  #   click_on 'Update Job'
  #
  #   expect(page).not_to have_content('Pivotal Labs')
  #   expect(page).to have_content('Viget Labs')
  # end

  def create_job_opportunity
    click_link 'Add a New Opportunity'
    fill_in(:job_opportunity_company_name, with: 'Pivotal Labs')
    fill_in(:job_opportunity_application_due_date, with: '07/30/2014')
    fill_in(:job_opportunity_company_location, with: 'San Francisco, CA')
    fill_in(:job_opportunity_contact_name, with: 'Miriam Fisher')
    fill_in(:job_opportunity_contact_email, with: 'miriam@example.com')
    fill_in(:job_opportunity_salary, with: '$68,000')
    fill_in(:job_opportunity_job_title, with: 'Junior Developer')
    select('Direct Application', from: :job_opportunity_application_type)
    select('Public', from: :job_opportunity_status)

    click_button 'Create Job Opportunity'
  end
end
