require 'spec_helper'


module Assessments
  describe Quiz do
    describe 'finding quizzes for a user' do
      it 'only includes quizzes for that user' do
        user1 = create_user
        user2 = create_user

        template = QuizTemplate.create!(name: 'Foo', question_text: 'bar')
        quiz1 = create_quiz(quiz_template: template, user: user1)
        create_quiz(quiz_template: template, user: user2)

        expect(Quiz.for_user(user1)).to match_array([quiz1])
      end
    end
  end
end