class AddTrackerProjectUrlToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :tracker_project_url, :string
  end
end
