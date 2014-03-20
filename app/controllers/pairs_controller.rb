class PairsController < InstructorRequiredController

  def index
    @cohort = Cohort.find(params[:cohort_id])
    @students = User.where(cohort_id: @cohort)

    if params[:strategy] == 'by_rank'
      @pair_generator = PairGenerator.new(@students)
      @pairs = @pair_generator.rank_based_pairs(Assessments::Ranking.where(student_id: @students))
    else
      @pair_generator = PairGenerator.new(@students)
      @pairs = @pair_generator.random_pairs
    end
  end

end