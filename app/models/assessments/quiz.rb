module Assessments
  class Quiz < ActiveRecord::Base
    STATUSES = [
      UNSUBMITTED = 'unsubmitted',
      SUBMITTED = 'submitted',
    ]

    belongs_to :user
    has_many :answers, class_name: 'Assessments::QuizAnswer'

    validates :quiz_name, presence: true
    validates :quiz_version, presence: true, numericality: true
    validates :status, inclusion: { in: STATUSES }

    def self.unsubmitted_for_user(user)
      where(status: UNSUBMITTED, user_id: user)
    end

    def full_name
      "#{quiz_name} (#{quiz_version})"
    end
  end
end