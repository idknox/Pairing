class StudentsController < SignInRequiredController

  def show
    @student = User.find(params[:id])
  end

end