class ProtectedPagesController < SignInRequiredController

  def student_dashboard
    cohort = user_session.current_user.cohort
    @exercises = cohort.exercises
  end

  def class_info
    @cohort = user_session.current_user.cohort
  end

end
