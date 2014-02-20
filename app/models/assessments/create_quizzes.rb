module Assessments

  CreateQuizzes = ->(quiz_template, users) {
    users.each do |user|
      quiz = Quiz.create!(
        status: Quiz::UNSUBMITTED,
        user: user,
        quiz_template: quiz_template,
      )

      quiz_template.questions.each.with_index do |question, index|
        QuizAnswer.create!(
          status: QuizAnswer::UNGRADED,
          user: user,
          quiz: quiz,
          question: question,
          question_index: index,
        )
      end
    end
    nil
  }

end