module Assessments
  class ShortAnswerQuizTemplatesController < InstructorRequiredController

    def index
      @quiz_templates = ShortAnswerQuizTemplate.order('created_at desc')
    end

    def show
      @quiz_template = ShortAnswerQuizTemplate.find(params[:id])
    end

    def new
      @quiz_template = ShortAnswerQuizTemplate.new
    end

    def create
      @quiz_template = ShortAnswerQuizTemplate.new(quiz_params)
      if @quiz_template.save
        redirect_to(
          assessments_short_answer_quiz_template_path(@quiz_template),
          notice: 'Template was created successfully'
        )
      else
        render action: :new
      end
    end

    protected

    def quiz_params
      params.require(:quiz_template).permit(:name, :version, :question_text)
    end

  end
end