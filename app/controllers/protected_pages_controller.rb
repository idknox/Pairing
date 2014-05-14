class ProtectedPagesController < SignInRequiredController

  def student_dashboard
    @cohort = user_session.current_user.cohort
  end

end
