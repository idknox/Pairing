class AddCohortIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cohort_id, :integer
    add_index :users, :cohort_id
  end
end
