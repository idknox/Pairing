class RemoveExerciseQuestions < ActiveRecord::Migration
  def change
    drop_table :comprehension_questions
    drop_table :answers
  end
end
