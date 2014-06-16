class Student::QuestionsController < SignInRequiredController
  def index
    @questions_by_day = ordered_questions_for_cohort(user_session.current_user.cohort_id)
    @question = Question.new
  end

  def create
    @question = Question.new(text: params[:question][:text], cohort_id: user_session.current_user.cohort_id)

    if @question.save
      flash[:notice] = "Question added."
      redirect_to action: :index
    else
      @questions_by_day = ordered_questions_for_cohort(user_session.current_user.cohort_id)
      render :index
    end
  end

  def update
    @question = Question.find(params[:id])
    @question.update(answered: true)
    redirect_to action: :index
  end

  private

  def ordered_questions_for_cohort(cohort_id)
    Question.for_cohort(cohort_id).order("created_at DESC").group_by { |q| q.created_at.to_date }
  end
end
