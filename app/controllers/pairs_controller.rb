class PairsController < InstructorRequiredController

  def index
    @cohort = Cohort.find(params[:cohort_id])
    @students = User.where(cohort_id: @cohort)

    @pair_generator = PairGenerator.new(@students)
    @pairs = @pair_generator.random_pairs
  end

end