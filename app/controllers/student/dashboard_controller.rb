class Student::DashboardController < SignInRequiredController
  def index
    @other_students = user_session.current_cohort.students - [user_session.current_user]
  end
end