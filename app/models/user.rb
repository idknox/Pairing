class User < ActiveRecord::Base

  INSTRUCTOR = 1

  validates_uniqueness_of :email, case_sensitive: false
  validates_uniqueness_of :github_id, case_sensitive: false, allow_nil: true
  validates_presence_of :email

  belongs_to :cohort

  def self.for_cohort(cohort_id)
    where(cohort_id: cohort_id)
  end

  scope :instructors, -> { where(role_bit_mask: 1) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def is?(role)
    role_bit_mask & role != 0
  end

  def add_role(role)
    self.role_bit_mask += role
  end
end