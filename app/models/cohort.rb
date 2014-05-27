class Cohort < ActiveRecord::Base
  validates :name, :directions, :google_maps_location, presence: true

  has_many :cohort_exercises
  has_many :exercises, through: :cohort_exercises
  has_many :users

  def students
    users.where.not(role_bit_mask: User::INSTRUCTOR)
  end
end
