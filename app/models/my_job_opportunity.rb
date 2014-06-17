class MyJobOpportunity < ActiveRecord::Base
  belongs_to :user
  belongs_to :job_opportunity
end