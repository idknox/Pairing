class SubmissionsController < SignInRequiredController

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(submission_params)

    if @submission.save!
      redirect_to my_exercises_path, notice: "Your code has been submitted"
    else
      render :new
    end
  end

  private

  def submission_params
    params.require(:submission).
      permit(:github_repo_name).
      merge(user_id: user_session.current_user.id, exercise_id: params[:exercise_id])
  end
end