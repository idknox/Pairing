class CreateAttendanceSheets < ActiveRecord::Migration
  def change
    create_table :attendance_sheets do |t|
      t.date :sheet_date
      t.integer :cohort_id

      t.timestamps
    end
  end
end
