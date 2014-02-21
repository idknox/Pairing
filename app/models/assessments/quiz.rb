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
      for_user(user).where(status: UNSUBMITTED)
    end

    def self.for_user(user)
      where(user_id: user)
    end

    def name
      quiz_template.name
    end

    def submit!
      update_attributes!(status: SUBMITTED)
    end

    def submitted?
      status == SUBMITTED
    end

    def unsubmitted?
      status == UNSUBMITTED
    end
  end
end