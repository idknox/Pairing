class User < ActiveRecord::Base
  validates_uniqueness_of :email, case_sensitive: false
  validates_uniqueness_of :github_id, case_sensitive: false, allow_nil: true

  def full_name
    "#{first_name} #{last_name}"
  end
end