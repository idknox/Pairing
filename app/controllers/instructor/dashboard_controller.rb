class Instructor::DashboardController < InstructorRequiredController
  def index
    @cohorts = Cohort.all
    @exercises = Exercise.all
  end
end