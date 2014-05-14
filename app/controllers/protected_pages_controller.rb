class ProtectedPagesController < SignInRequiredController

  def student_dashboard
  end

  def class_info
    @cohort = user_session.current_user.cohort
  end

end
