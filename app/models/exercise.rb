class Exercise < ActiveRecord::Base
  has_many :submissions
  validates :name, :github_repo, presence: true

  def completed_by?(user_id)
    submissions.find_by(user_id: user_id).present?
  end
end
