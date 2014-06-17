class JobOpportunity < ActiveRecord::Base
  belongs_to :user
  has_many :my_job_opportunities
  has_many :users, through: :my_job_opportunities
end