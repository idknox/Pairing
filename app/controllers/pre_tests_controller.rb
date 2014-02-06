class PreTestsController < ApplicationController

  def show
    pre_test = PreTest.find_by(user_id: user_session.current_user.id)
    render :new and return unless pre_test

    render :show, locals: {
      pre_test_presenter: PreTestPresenter.new(pre_test),
      pre_test: pre_test
    }
  end

  def create
    PreTest.create!(user: user_session.current_user)
    redirect_to pre_test_question_path(PreTestQuestion.first)
  end

  def question
    pre_test = PreTest.find_by(user_id: user_session.current_user.id)
    question = PreTestQuestion.find(params[:question_id])
    answer = pre_test.answer_for(question)

    render :question, locals: { question: question, pre_test_answer: answer }
  end

  def update_answer
    pre_test = PreTest.find_by(user_id: user_session.current_user.id)
    question = PreTestQuestion.find(params[:question_id])
    pre_test.update_answer_for(question, params[:pre_test_answer][:answer_text])

    redirect_to_next_question(question)
  end

  def submit
    pre_test = PreTest.find_by(user_id: user_session.current_user.id)
    pre_test.submitted = true
    pre_test.save!
    redirect_to pre_test_path, notice: "Thanks! All done."
  end

  private

  def redirect_to_next_question(question)
    next_question = PreTestQuestion.question_after(question)
    if next_question
      redirect_to pre_test_question_path(next_question)
    else
      redirect_to pre_test_path, notice: 'That was the last question!  Review your answers and submit below.'
    end
  end

end



