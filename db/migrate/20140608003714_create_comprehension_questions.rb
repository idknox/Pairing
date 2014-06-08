class CreateComprehensionQuestions < ActiveRecord::Migration
  def change
    create_table :comprehension_questions do |t|
      t.text :text

      t.timestamps
    end
  end
end
