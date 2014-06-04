class Student::QuestionsController < SignInRequiredController
  def index
    @questions_by_day = Question.all.group_by {|q| q.created_at.to_date }
    @new_question = Question.new
  end

  def create
    Question.create!(text: params[:question][:text])
    flash[:notice] = "Question added."
    redirect_to action: :index
  end
end