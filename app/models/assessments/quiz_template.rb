module Assessments
  class QuizTemplate < ActiveRecord::Base
    validates :name, presence: true
    validates :question_text, presence: true

    def questions
      question_text.split("\n").map(&:strip)
    end
  end
end