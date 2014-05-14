class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment

  validates :user, :assignment, :github_repo_name, presence: true

  def user_name
    user.full_name
  end

  def github_repo_url
    "https://github.com/#{user.github_username}/#{github_repo_name}"
  end
end
