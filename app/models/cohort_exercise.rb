class CohortExercise < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :cohort

  delegate :submissions, :name, to: :exercise

  def students_missing_submission
    cohort.users - submissions.map(&:user)
  end
end