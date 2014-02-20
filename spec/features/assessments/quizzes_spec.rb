require 'spec_helper'

feature 'quizzes' do

  let(:cohort) { Cohort.create!(name: 'g2') }
  let!(:student) { create_user(first_name: "Github", last_name: "User", github_id: '123', cohort: cohort) }

  scenario 'students fill out quizzes' do
    quiz_template = Assessments::QuizTemplate.create!(name: 'Ruby Basics', question_text: "who is bob\nwho is nate")
    Assessments::CreateQuizzes.call(quiz_template, [student])

    sign_in(student)
    visit dashboard_path
    click_on 'Ruby Basics'
    fill_in 'who is bob', with: 'foobar'
    fill_in 'who is nate', with: 'baz'
    click_button 'Save'
    expect(page).to have_content('who is bob', 'foobar')
    expect(page).to have_content('who is nate', 'baz')
    expect(page).to have_content('Edit Answers')

    click_on 'Submit This Quiz'
    expect(page).to have_content('who is bob', 'foobar')
    expect(page).to have_content('who is nate', 'baz')
    expect(page).to_not have_content('Edit Answers')
  end

end