class AllowResumeToBeNilOnApplication < ActiveRecord::Migration
  def change
    change_column :applications, :resume, :string, :null => true
  end
end
