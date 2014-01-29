class CreateFeedbackEntries < ActiveRecord::Migration
  def change
    create_table :feedback_entries do |t|
      t.integer :recipient_id
      t.text :comment
      t.integer :provider_id

      t.timestamps
    end
  end
end
