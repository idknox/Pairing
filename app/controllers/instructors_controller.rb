class InstructorsController < InstructorRequiredController
  def dashboard
    @cohorts = Cohort.all
  end
end