class AddGoogleMapsLocationToCohort < ActiveRecord::Migration
  def change
    add_column :cohorts, :google_maps_location, :text
  end
end
