class CohortAssignmentsController < InstructorRequiredController
  def index
    @cohort = Cohort.find(params[:cohort_id])
    @cohort_assignments = CohortAssignment.where(cohort_id: @cohort.id).includes(:assignment)
  end

  def new
    @cohort = Cohort.find(params[:cohort_id])
  end

  def create
    @cohort_assignment = CohortAssignment.new(create_params)

    if @cohort_assignment.save
      redirect_to cohort_assignments_path, notice: 'Assignment successfully added to cohort'
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:cohort_assignment).
      permit(:assignment_id).
      merge(cohort_id: params[:cohort_id])
  end
end