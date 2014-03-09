class CohortsController < SignInRequiredController

  before_action :signed_in?

  def index
    @cohorts = Cohort.all
  end

  def show
    render 'show',
           locals: {
               students: User.where(cohort_id: params[:id])
           }
  end

  protected

  def signed_in?
    unless user_session.current_user.is?(User::INSTRUCTOR)
      redirect_to root_path
    end
  end

end