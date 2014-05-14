class DropQuizAndRankRelatedTables < ActiveRecord::Migration
  def change
    drop_table :quiz_answers
    drop_table :quiz_templates
    drop_table :quizzes
    drop_table :rankings
  end
end
