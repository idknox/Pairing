class Assignment < ActiveRecord::Base
  validates :name, :github_repo, presence: true
end
