module Assessments
  class ShortAnswerQuizAnswer < ActiveRecord::Base
    STATUSES = [
      UNGRADED = 'ungraded',
      CORRECT = 'correct',
      INCORRECT = 'incorrect',
    ]

    belongs_to :user
    belongs_to :short_answer_quiz, class_name: 'Assessments::ShortAnswerQuiz'
    validates :question, presence: true
    validates :status, inclusion: {in: STATUSES}
  end
end