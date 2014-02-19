module Assessments
  class QuizAnswer < ActiveRecord::Base
    STATUSES = [
      UNGRADED = 'ungraded',
      CORRECT = 'correct',
      INCORRECT = 'incorrect',
    ]

    belongs_to :user
    belongs_to :quiz, class_name: 'Assessments::Quiz'
    validates :question, presence: true
    validates :status, inclusion: {in: STATUSES}
  end
end