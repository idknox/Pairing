class CohortsController < SignInRequiredController

  before_action :signed_in?

  def index
    @cohorts = Cohort.all
  end

  def show
    students = User.for_cohort(params[:id])
    render 'show',
           locals: {
               students: students,
               lucky_winner: students.sample
           }
  end

  protected

  def signed_in?
    unless user_session.current_user.is?(User::INSTRUCTOR)
      redirect_to root_path
    end
  end

end