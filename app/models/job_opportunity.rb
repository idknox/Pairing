class JobOpportunity < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  has_many :my_job_opportunities
  has_many :applications

  has_many :users, through: :my_job_opportunities
  has_many :applicants, through: :applications, source: :user
end