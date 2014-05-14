class CohortAssignment < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :cohort

  delegate :submissions, :name, to: :assignment

  def students_missing_submission
    cohort.users - submissions.map(&:user)
  end
end