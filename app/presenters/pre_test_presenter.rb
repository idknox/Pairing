class PreTestPresenter

  attr_reader :pre_test

  def initialize(pre_test)
    @pre_test = pre_test
  end

  def answers
    answers = answers_by_question_id

    PreTestQuestion.all.map { |question|
      answer = answers[question.id]
      AnswerPresenter.new(question, answer)
    }
  end

  private

  def answers_by_question_id
    all_answers = PreTestAnswer.where(pre_test_id: pre_test)
    all_answers.inject({}) do |hash, answer|
      hash[answer.question_id] = answer
      hash
    end
  end

end
