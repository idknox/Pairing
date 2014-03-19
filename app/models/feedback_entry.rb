class FeedbackEntry < ActiveRecord::Base
  validates :recipient_id, presence: true
  validates :provider_id, presence: true
  validates :comment, presence: true

  belongs_to :provider, class_name: "User"
  belongs_to :recipient, class_name: "User"

  def self.given_to(user)
    where(recipient_id: user.id)
  end

  def self.given_by(user)
    where(provider_id: user)
  end
end