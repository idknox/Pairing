class StudentsController < SignInRequiredController

  def show
    @student = User.find(params[:id])
  end

  def edit
    @student = User.find(params[:id])
  end

end
