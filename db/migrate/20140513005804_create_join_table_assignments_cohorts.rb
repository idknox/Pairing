class CreateJoinTableAssignmentsCohorts < ActiveRecord::Migration
  def change
    create_table :assignments_cohorts do |t|
      t.integer :assignment_id
      t.integer :cohort_id

      t.timestamps
    end
  end
end
