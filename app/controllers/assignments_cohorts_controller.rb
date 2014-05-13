class AssignmentsCohortsController < InstructorRequiredController
  def index
    @cohort = Cohort.find(params[:cohort_id])
    @assignments_cohorts = AssignmentsCohort.where(cohort_id: @cohort.id).includes(:assignment)
  end

  def new
    @cohort = Cohort.find(params[:cohort_id])
  end

  def create
    @assignments_cohort = AssignmentsCohort.new(create_params)

    if @assignments_cohort.save
      redirect_to cohort_assignments_path, notice: 'Assignment successfully added to cohort'
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:assignments_cohort).
      permit(:assignment_id).
      merge(cohort_id: params[:cohort_id])
  end
end