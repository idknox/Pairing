class StudentsController < InstructorRequiredController
  def new
    @student = User.new
  end

  def create
    @student = User.new(create_params)

    if @student.save
      flash[:notice] = 'Student added succesfully'
      redirect_to cohort_path(params[:cohort_id])
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:student)
          .permit(:first_name, :last_name, :email)
          .merge(cohort_id: params[:cohort_id])
  end
end
