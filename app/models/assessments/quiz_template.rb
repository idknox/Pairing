module Assessments
  class QuizTemplate < ActiveRecord::Base
    validates :name, presence: true
    validates :uuid, presence: true, uniqueness: { case_sensitive: false }
    validates :question_text, presence: true

    before_validation on: :create do
      self.uuid = SecureRandom.uuid unless uuid?
    end

    def full_name
      "#{name} (#{uuid})"
    end

    def questions
      question_text.split("\n").map(&:strip)
    end
  end
end