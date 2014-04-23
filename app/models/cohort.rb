class Cohort < ActiveRecord::Base
  validates :name, :directions, :google_maps_location, presence: true
end
