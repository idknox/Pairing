class CohortsController < SignInRequiredController
  
  before_action :signed_in?
  
  def index
    @cohorts = Cohort.all
  end
  
  def pretest
    @cohort = Cohort.find(params[:id])
    @questions = PreTestQuestion.all
  end
  
  protected
  
  def signed_in?
    unless user_session.current_user.is?(User::INSTRUCTOR)
      redirect_to root_path
    end
  end

end