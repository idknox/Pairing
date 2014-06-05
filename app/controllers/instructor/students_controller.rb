class Instructor::StudentsController < InstructorRequiredController
  def new
    @student = User.new
  end

  def create
    @student = User.new(create_params)

    if @student.save
      flash[:notice] = 'Student added successfully'
      StudentMailer.invitation(@student.email).deliver
      redirect_to instructor_cohort_path(params[:cohort_id])
    else
      render :new
    end
  end

  def show
    @student = User.find(params[:id])
  end

  private

  def create_params
    params.require(:student)
          .permit(:first_name, :last_name, :email)
          .merge(cohort_id: params[:cohort_id])
  end
end
