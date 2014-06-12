class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.references :attendance_sheet
      t.boolean :in_class

      t.timestamps
    end
  end
end
