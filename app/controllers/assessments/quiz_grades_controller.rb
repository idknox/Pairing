module Assessments
  class QuizGradesController < InstructorRequiredController

    def summary
      @cohort = Cohort.find(params[:cohort_id])

      @quizzes = Quiz.where(quiz_uuid: params[:uuid]).
        joins(:user).
        references(:user).
        where(users: { cohort_id: params[:cohort_id] })

      @quiz_name = @quizzes.map(&:quiz_name).uniq.first

      @questions = @quizzes.map(&:answers).flatten.map(&:question).uniq
    end

    def question
      @cohort = Cohort.find(params[:cohort_id])

      @answers = QuizAnswer.
        joins(quiz: :user).
        references(:quiz, :user).
        where(
        question: params[:question],
        quizzes: { quiz_uuid: params[:uuid] },
        users: { cohort_id: params[:cohort_id] }
      )

      @quiz_name = @answers.map(&:quiz).map(&:quiz_name).uniq.first
    end

    def grade_question
      params[:answers].each do |id, status|
        QuizAnswer.update(id, status: status)
      end
      
      redirect_to assessments_quiz_grades_summary_path(params[:cohort_id], params[:uuid])
    end

  end
end