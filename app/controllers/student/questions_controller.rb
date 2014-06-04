class Student::QuestionsController < SignInRequiredController
  def index
    @questions_by_day = Question.all.group_by { |q| q.created_at.to_date }
    @question = Question.new
  end

  def create
    @question = Question.new(text: params[:question][:text], cohort_id: user_session.current_user.cohort_id)

    if @question.save
      flash[:notice] = "Question added."
      redirect_to action: :index
    else
      @questions_by_day = Question.all.group_by { |q| q.created_at.to_date }
      render :index
    end
  end
end