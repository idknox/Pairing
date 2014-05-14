class CohortAssignmentsController < InstructorRequiredController
  def index
    @cohort = Cohort.find(params[:cohort_id])
    @assignments = @cohort.assignments
  end

  def show
    @assignment = CohortAssignment.includes(:assignment).find_by!(cohort_id: params[:cohort_id])
    @submissions = @assignment.submissions
    @students_missing_submission = @assignment.students_missing_submission
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