class Student::StudentsController < SignInRequiredController
  def index
    @students = user_session.current_cohort.students
  end
end