class Application < ActiveRecord::Base
  mount_uploader :resume, ResumeUploader
  belongs_to :job_opportunity
  belongs_to :user

  enum status: ["pending", "applied"]

  validates_uniqueness_of :job_opportunity_id, scope: [:user_id]
end
