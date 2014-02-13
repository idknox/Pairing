class PreTest < ActiveRecord::Base
  belongs_to :user

  scope :submitted, -> { where(submitted: true) }

  def in_progress?
    !submitted?
  end

  def answer_for(question)
    PreTestAnswer.find_or_initialize_by(question_id: question.id, pre_test_id: self.id)
  end

  def update_answer_for(question, answer_text)
    answer = answer_for(question)
    answer.answer_text = answer_text
    answer.save!
  end

end