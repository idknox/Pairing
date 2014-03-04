module Assessments
  class QuizGradesController < InstructorRequiredController

    def summary
      @cohort = Cohort.find(params[:cohort_id])

      quiz_template = QuizTemplate.find(params[:quiz_template_id])
      quizzes = Quiz.where(quiz_template_id: quiz_template).
        joins(:user).
        references(:user).
        where(users: { cohort_id: @cohort })

      @quiz_name = quiz_template.name
      @submitted_quizzes = quizzes.to_a.count { |quiz| quiz.status == Quiz::SUBMITTED }
      @unsubmitted_quizzes = quizzes.to_a.count { |quiz| quiz.status == Quiz::UNSUBMITTED }

      @question_presenters = base_scope.group_by(&:question_index).map do |question_index, answers|
        OpenStruct.new(
          question: quiz_template.questions[question_index],
          question_index: question_index,
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
      @answers = base_scope.where(question_index: params[:question_index]).sort_by { |answer| answer_sort_order[answer.status] }

      quiz_template = QuizTemplate.find(params[:quiz_template_id])
      @quiz_name = quiz_template.name
      @question = quiz_template.questions[params[:question_index].to_i]
    end

    def grade_question
      params[:answers].each do |id, status|
        QuizAnswer.update(id, status: status)
      end

      redirect_to assessments_quiz_grades_summary_path(params[:cohort_id], params[:quiz_template_id])
    end

    private

    def base_scope
      QuizAnswer.joins(:user, :quiz).
        references(:user, :quiz).
        where(users: { cohort_id: @cohort }).
        where(quizzes: { quiz_template_id: params[:quiz_template_id], status: Quiz::SUBMITTED }).
        order(:question)
    end

  end
end