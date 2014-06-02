class Instructor::ExercisesController < InstructorRequiredController
  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      redirect_to instructor_dashboard_path, notice: 'Exercise successfully created'
    else
      render :new
    end
  end

  def show
    @exercise = Exercise.find(params[:id])
  end

  def edit
    @exercise = Exercise.find(params[:id])
  end

  def update
    @exercise = Exercise.find(params[:id])

    if @exercise.update_attributes(exercise_params)
      redirect_to instructor_dashboard_path, notice: 'Exercise successfully created'
    else
      render :edit
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :github_repo, :tag_list)
  end
end