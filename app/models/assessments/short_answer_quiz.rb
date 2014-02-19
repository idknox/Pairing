module Assessments
  class ShortAnswerQuiz < ActiveRecord::Base
    STATUSES = [
      UNSUBMITTED = 'unsubmitted',
      SUBMITTED = 'submitted',
    ]
    
    belongs_to :user
    validates :quiz_name, presence: true
    validates :quiz_version, presence: true, numericality: true
    validates :status, inclusion: {in: STATUSES}
  end
end