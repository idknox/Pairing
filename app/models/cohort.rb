class Cohort < ActiveRecord::Base
  validates :name, :directions, :google_maps_location, presence: true

  has_many :assignments_cohorts
  has_many :assignments, through: :assignments_cohorts
end
