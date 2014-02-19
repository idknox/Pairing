class InstructorRequiredController < SignInRequiredController
  before_action :require_instructor
  
  protected
  
  def require_instructor
    user_session.current_user.is?(User::INSTRUCTOR)
  end
end