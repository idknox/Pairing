module Assessments
  class QuizAnswer < ActiveRecord::Base
    STATUSES = [
      CORRECT = 'correct',
      INCORRECT = 'incorrect',
      UNGRADED = 'ungraded',
    ]

    belongs_to :user
    belongs_to :quiz, class_name: 'Assessments::Quiz'
    validates :question, presence: true
    validates :status, inclusion: {in: STATUSES}

    def correct?
      status == CORRECT
    end

    def incorrect?
      status == INCORRECT
    end
  end
end