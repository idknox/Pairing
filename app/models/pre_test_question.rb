class PreTestQuestion < ActiveRecord::Base

  def self.question_after(question)
    where('id > ?', question.id).first
  end

end
