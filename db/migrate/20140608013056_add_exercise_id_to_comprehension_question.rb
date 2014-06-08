class AddExerciseIdToComprehensionQuestion < ActiveRecord::Migration
  def change
    add_reference :comprehension_questions, :exercise
  end
end
