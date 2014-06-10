class Exercise < ActiveRecord::Base
  acts_as_taggable
  has_many :submissions
  validates :name, :github_repo, presence: true

  def submission_for(user_id)
    submissions.find_by(user_id: user_id)
  end

  def github_repo_url
    "https://github.com/gSchool/#{github_repo}"
  end
end
