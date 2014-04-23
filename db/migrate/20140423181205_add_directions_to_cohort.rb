class AddDirectionsToCohort < ActiveRecord::Migration
  def change
    add_column :cohorts, :directions, :text
  end
end
