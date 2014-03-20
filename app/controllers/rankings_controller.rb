class RankingsController < InstructorRequiredController
  def index
    @cohort = Cohort.find(params[:cohort_id])
    @students = User.where(cohort_id: @cohort).sort_by { |student| student.full_name.downcase }
  end

  def create
    params[:students].each do |student_id, attributes|
      ranking = Assessments::Ranking.find_or_initialize_by(student_id: student_id)
      ranking.score = attributes[:rank]
      ranking.save!
    end

    redirect_to cohort_path(params[:cohort_id]), notice: "Rankings were saved"
  end
end
