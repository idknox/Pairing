class PreTestAnswer < ActiveRecord::Base

  STATUSES = [
    UNGRADED = 'ungraded',
    CORRECT = 'correct',
    'incorrect',
  ]

  belongs_to :pre_test
  belongs_to :question, class_name: 'PreTestQuestion'

  validates :status, inclusion: { in: STATUSES }

  def self.for_cohort_and_question(cohort, question)
    joins(pre_test: :user).
      where("cohort_id = ?", cohort).
      where(question_id: question).
      order('pre_test_answers.id')
  end

  def graded?
    status != UNGRADED
  end

  def correct?
    status == CORRECT
  end

end