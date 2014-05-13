class InstructorsController < InstructorRequiredController
  def dashboard
    @cohorts = Cohort.all
    @assignments = Assignment.all
  end
end