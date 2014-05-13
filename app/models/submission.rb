class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment

  validates :user, :assignment, :github_repo_name, presence: true
end
