class AnswerPresenter
  def initialize(question, answer)
    @question = question
    @answer = answer
  end

  def question
    @question.text
  end

  def answer
    @answer ? @answer.answer_text : ""
  end

  def question_id
    @question.id
  end
end
