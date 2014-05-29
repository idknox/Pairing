class Instructor::DashboardController < InstructorRequiredController
  def index
    @cohorts = Cohort.all
    @exercises = Exercise.order(:name).all
  end
end