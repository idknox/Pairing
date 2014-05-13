class ChangeAssignmentsCohortToCohortAssignment < ActiveRecord::Migration
  def change
    rename_table :assignments_cohorts, :cohort_assignments
  end
end
