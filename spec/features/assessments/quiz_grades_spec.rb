require 'spec_helper'

feature 'quiz templates crud' do

  let(:cohort) { Cohort.create!(name: 'g2') }
  let(:instructor) { create_user(first_name: "Github", last_name: "User", github_id: '123', role_bit_mask: User::INSTRUCTOR) }
  let!(:student) { create_user(first_name: "Github", last_name: "User", github_id: '234', cohort: cohort) }

  scenario 'instructors can create quiz templates' do
    quiz_template = Assessments::QuizTemplate.create!(name: 'Ruby Basics', question_text: "who is bob\nwho is nate")
    Assessments::CreateQuizzes.call(quiz_template, cohort)
    quiz = Assessments::Quiz.find_by(user_id: student)
    quiz.update_attributes!(status: Assessments::Quiz::SUBMITTED)
    quiz_answer1 = quiz.answers.find_by(question: 'who is bob')
    quiz_answer1.update_attributes(text: 'some answer')
    quiz_answer2 = quiz.answers.find_by(question: 'who is nate')
    quiz_answer2.update_attributes(text: 'some other answer')

    sign_in(instructor)
    visit cohorts_path
    click_on 'Ruby Basics'
    click_on 'Grade 1 ungraded answer', match: :first
    within("#answer_#{quiz_answer1.id}") do
      choose 'Correct', match: :first
    end

    click_on 'Save Grades'

    expect(quiz_answer1.reload.status).to eq(Assessments::QuizAnswer::CORRECT)
  end

end