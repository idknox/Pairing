class MoveComprehensionQuestionsToCohortExercises < ActiveRecord::Migration
  def change
    remove_reference :comprehension_questions, :exercise
    add_reference :comprehension_questions, :cohort_exercise
  end
end
