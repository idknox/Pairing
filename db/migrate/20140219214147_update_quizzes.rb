class UpdateQuizzes < ActiveRecord::Migration
  def change
    remove_column :quiz_templates, :version
    add_column :quiz_templates, :uuid, :string

    remove_column :quizzes, :quiz_version
    add_column :quizzes, :quiz_uuid, :string
  end
end
