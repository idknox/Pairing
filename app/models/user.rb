class User < ActiveRecord::Base

  INSTRUCTOR = 1

  validates_uniqueness_of :email, case_sensitive: false
  validates_uniqueness_of :github_id, case_sensitive: false, allow_nil: true
  validates_presence_of :email

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