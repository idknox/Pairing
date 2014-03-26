class JobOpportunity < ActiveRecord::Base
  def self.jobs_for_student(user)
    where(user_id: user.id)
  end
end