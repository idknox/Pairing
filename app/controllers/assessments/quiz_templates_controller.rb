module Assessments
  class QuizTemplatesController < InstructorRequiredController

    def index
      @quiz_templates = QuizTemplate.order('created_at desc')
    end

    def show
      @quiz_template = QuizTemplate.find(params[:id])
    end

    def new
      @quiz_template = QuizTemplate.new
    end

    def create
      @quiz_template = QuizTemplate.new(quiz_params)
      if @quiz_template.save
        redirect_to(
          assessments_quiz_template_path(@quiz_template),
          notice: 'Template was created successfully'
        )
      else
        render action: :new
      end
    end

    def create_quiz
      @quiz_template = QuizTemplate.find(params[:id])
      @cohort = Cohort.find(params[:template_creator][:cohort_id])
      Assessments::CreateQuizzes.call(@quiz_template, @cohort)
      redirect_to(
        assessments_quiz_template_path(@quiz_template),
        notice: 'Quizzes were created'
      )
    end

    protected

    def quiz_params
      params.require(:quiz_template).permit(:name, :uuid, :question_text)
    end

  end
end