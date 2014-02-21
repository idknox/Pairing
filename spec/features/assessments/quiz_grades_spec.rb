require 'spec_helper'

feature 'Quiz grades' do

  let(:cohort) { Cohort.create!(name: 'g2') }
  let(:instructor) { create_user(first_name: "Github", last_name: "User", github_id: '123', role_bit_mask: User::INSTRUCTOR) }
  let!(:student) { create_user(first_name: "Github", last_name: "User", github_id: '234', cohort: cohort) }

  scenario 'Instructor and grade a quiz and student can see what they got right and wrong' do
    quiz_template = Assessments::QuizTemplate.create!(name: 'Ruby Basics', question_text: "who is bob\nwho is nate")
    Assessments::CreateQuizzes.call(quiz_template, [student])
    quiz = Assessments::Quiz.find_by(user_id: student)
    quiz.update_attributes!(status: Assessments::Quiz::SUBMITTED)
    quiz_answer1 = quiz.answers.find_by(question: 'who is bob')
    quiz_answer1.update_attributes(text: 'some answer')
    quiz_answer2 = quiz.answers.find_by(question: 'who is nate')
    quiz_answer2.update_attributes(text: 'some other answer')

    sign_in(instructor)
    visit cohorts_path
    click_on 'Ruby Basics'

    click_on 'who is bob'
    within("#answer_#{quiz_answer1.id}") do
      choose 'Correct', match: :first
    end
    click_on 'Save Grades'

    click_on 'who is nate'
    within("#answer_#{quiz_answer2.id}") do
      choose 'Incorrect', match: :first
    end
    click_on 'Save Grades'

    click_on I18n.t('nav.sign_out')

    sign_in(student)
    click_on 'Quizzes'

    click_on 'Ruby Basics'

    within("#answer_#{quiz_answer1.id}") do
      expect(page).to have_content "Correct"
    end

    within("#answer_#{quiz_answer2.id}") do
      expect(page).to have_content "Incorrect"
    end
  end
end