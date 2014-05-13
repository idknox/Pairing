class AssignmentsController < InstructorRequiredController
  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = Assignment.new(create_params)

    if @assignment.save
      redirect_to instructor_dashboard_path, notice: 'Assignment successfully created'
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:assignment).permit(:name, :github_repo)
  end
end