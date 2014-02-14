class DropPreTests < ActiveRecord::Migration
  def change
    drop_table :pre_test_answers
    drop_table :pre_test_questions
    drop_table :pre_tests
  end
end
