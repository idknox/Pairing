class JobOpportunity < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  has_many :applications

  has_many :applicants, through: :applications, source: :user
end
