module Assessments
  class QuizGradesController < InstructorRequiredController

    def summary
      @cohort = Cohort.find(params[:cohort_id])

      quizzes = Quiz.where(quiz_uuid: params[:uuid]).
        joins(:user).
        references(:user).
        where(users: { cohort_id: params[:cohort_id] })

      @quiz_name = quizzes.map(&:quiz_name).uniq.first
      @submitted_quizzes = quizzes.to_a.count { |quiz| quiz.status == Quiz::SUBMITTED }
      @unsubmitted_quizzes = quizzes.to_a.count { |quiz| quiz.status == Quiz::UNSUBMITTED }

      @question_presenters = base_scope.group_by(&:question).map do |question, answers|
        OpenStruct.new(
          question: question,
          ungraded_answers: answers.count { |answer| answer.status == Assessments::QuizAnswer::UNGRADED },
          correct_answers: answers.count { |answer| answer.status == Assessments::QuizAnswer::CORRECT },
          incorrect_answers: answers.count { |answer| answer.status == Assessments::QuizAnswer::INCORRECT },
        )
      end
    end

    def question
      @cohort = Cohort.find(params[:cohort_id])

      answer_sort_order = {
        Assessments::QuizAnswer::UNGRADED => 0,
        Assessments::QuizAnswer::INCORRECT => 1,
        Assessments::QuizAnswer::CORRECT => 2
      }
      @answers = base_scope.where(question: params[:question]).sort_by { |answer| answer_sort_order[answer.status] }

      @quiz_name = @answers.map(&:quiz).map(&:quiz_name).uniq.first
    end

    def grade_question
      params[:answers].each do |id, status|
        QuizAnswer.update(id, status: status)
      end

      redirect_to assessments_quiz_grades_summary_path(params[:cohort_id], params[:uuid])
    end

    private

    def base_scope
      QuizAnswer.joins(:user, :quiz).
        references(:user, :quiz).
        where(users: { cohort_id: @cohort }).
        where(quizzes: { quiz_uuid: params[:uuid], status: Quiz::SUBMITTED }).
        order(:question)
    end

  end
end