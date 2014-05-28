class Instructor::ExercisesController < InstructorRequiredController
  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(create_params)

    if @exercise.save
      redirect_to instructor_dashboard_path, notice: 'Exercise successfully created'
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:exercise).permit(:name, :github_repo)
  end
end