require 'spec_helper'

feature 'quiz templates crud' do

  let(:instructor) { create_user(first_name: "Github", last_name: "User", github_id: '123', role_bit_mask: User::INSTRUCTOR) }
  let!(:cohort) { Cohort.create!(name: 'g1') }

  scenario 'instructors can create quiz templates' do
    sign_in(instructor)
    click_on 'Quiz Templates'
    click_on 'New Template'
    click_on 'Create Quiz template'
    expect(page).to have_content('This form could not be saved')
    expect(page).to have_content("Name can't be blank")
    fill_in 'Name', with: 'Ruby'
    fill_in 'Question text', with: "Name a cat\nName a dog"
    click_on 'Create Quiz template'
    expect(page).to have_content('Template was created successfully')
    expect(page).to have_content('Name a cat', 'Name a dog')

    select 'g1', from: 'template_creator_cohort_id'
    click_on 'Create Quizzes for Cohort'
    expect(page).to have_content('Quizzes were created')

    select 'Github User', from: 'template_creator_user_id'
    click_on 'Create Quiz for User'
    expect(page).to have_content('Quizzes were created')
  end

end