class Instructor::ComprehensionQuestionsController < InstructorRequiredController
  def new
    @comprehension_question = ComprehensionQuestion.new
    4.times { @comprehension_question.answers.build }
  end

  def create
    @comprehension_question = ComprehensionQuestion.new(
      comprehension_question_params.merge(cohort_exercise_id: params[:cohort_exercise_id])
    )

    if @comprehension_question.save
      flash[:success] = "Question created successfully"
      redirect_to instructor_cohort_cohort_exercise_path(params[:cohort_id], params[:cohort_exercise_id])
    else
      render :new
    end
  end

  def show
    @comprehension_question = ComprehensionQuestion.find(params[:id])
  end

  def destroy
    ComprehensionQuestion.find(params[:id]).destroy
    flash[:success] = "Question deleted"
    redirect_to instructor_cohort_cohort_exercise_path(params[:cohort_id],
                                                       params[:cohort_exercise_id])
  end

  private

  def comprehension_question_params
    params.require(:comprehension_question).permit(:text, answers_attributes: [:text])
  end
end