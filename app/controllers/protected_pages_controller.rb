class ProtectedPagesController < SignInRequiredController

  def student_dashboard
    cohort = user_session.current_user.cohort
    @assignments = cohort.assignments
  end

  def class_info
    @cohort = user_session.current_user.cohort
  end

end
