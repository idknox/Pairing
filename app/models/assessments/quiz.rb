module Assessments
  class Quiz < ActiveRecord::Base
    STATUSES = [
      UNSUBMITTED = 'unsubmitted',
      SUBMITTED = 'submitted',
    ]

    belongs_to :user
    belongs_to :quiz_template, class_name: 'Assessments::QuizTemplate'
    has_many :answers, class_name: 'Assessments::QuizAnswer'

    validates :quiz_template, presence: true
    validates :status, inclusion: { in: STATUSES }

    def self.unsubmitted_for_user(user)
      where(status: UNSUBMITTED, user_id: user)
    end

    def name
      quiz_template.name
    end
  end
end