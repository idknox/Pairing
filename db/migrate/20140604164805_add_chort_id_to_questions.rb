class AddChortIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :cohort_id, :integer
  end
end
