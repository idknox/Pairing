class InstructorsController < InstructorRequiredController
  def dashboard
    @cohorts = Cohort.all
    @exercises = Exercise.all
  end
end