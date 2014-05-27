class Student::DashboardController < SignInRequiredController
  def index
    @exercises = user_session.current_cohort.exercises
  end
end