module Assessments
  class QuizzesController < SignInRequiredController

    def index
      render 'index', locals: {quizzes: Quiz.for_user(user_session.current_user)}
    end

    def show
      @quiz = Quiz.find(params[:id])
    end

    def edit
      @quiz = Quiz.find(params[:id])
      raise 'Access Denied' unless @quiz.status == Quiz::UNSUBMITTED
    end

    def update
      @quiz = Quiz.find(params[:id])

      if @quiz.submitted?
        flash[:notice] = I18n.t("assessments.quiz.already_submitted")
      else
        params[:quiz][:answers].each do |id, text|
          answer = @quiz.answers.find(id)
          answer.text = text
          answer.save!
        end
      end
      redirect_to assessments_quiz_path(@quiz)
    end

    def submit
      @quiz = Quiz.find(params[:id])
      @quiz.submit!
      redirect_to assessments_quiz_path(@quiz)
    end

  end
end