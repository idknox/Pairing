module Assessments
  class QuizTemplate < ActiveRecord::Base
    validates(
      :name,
      presence: true,
      uniqueness: { scope: :version, case_sensitive: false, message: 'has already been taken with this version' }
    )
    validates :version, presence: true, numericality: true
    validates :question_text, presence: true

    def full_name
      "#{name} (#{version})"
    end

    def questions
      question_text.split("\n")
    end
  end
end