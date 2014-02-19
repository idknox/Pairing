class ProtectedPagesController < SignInRequiredController

  def dashboard
    @unsubmitted_quizzes = Assessments::Quiz.unsubmitted_for_user(user_session.current_user)
  end

end