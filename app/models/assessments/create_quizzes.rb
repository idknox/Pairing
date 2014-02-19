module Assessments

  CreateQuizzes = ->(quiz_template, cohort) {
    User.where(cohort_id: cohort).each do |user|
      quiz = Quiz.create!(
        status: Quiz::UNSUBMITTED,
        user: user,
        quiz_name: quiz_template.name,
        quiz_version: quiz_template.version,
      )

      quiz_template.questions.each do |question|
        QuizAnswer.create!(
          status: QuizAnswer::UNGRADED,
          user: user,
          quiz: quiz,
          question: question,
        )
      end
    end
    nil
  }

end