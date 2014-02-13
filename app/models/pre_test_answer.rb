class PreTestAnswer < ActiveRecord::Base

  belongs_to :pre_test
  belongs_to :question, class_name: 'PreTestQuestion'

  def self.for_cohort_and_question(cohort, question)
    joins(pre_test: :user).
      where("cohort_id = ?", cohort).
      where(question_id: question).
      order('pre_test_answers.id')
  end

end