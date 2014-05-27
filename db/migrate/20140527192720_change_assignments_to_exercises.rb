class ChangeAssignmentsToExercises < ActiveRecord::Migration
  def change
    rename_table :assignments, :exercises
    rename_table :cohort_assignments, :cohort_exercises
    rename_column :cohort_exercises, :assignment_id, :exercise_id
    rename_column :submissions, :assignment_id, :exercise_id
  end
end
