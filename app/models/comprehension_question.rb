class ComprehensionQuestion < ActiveRecord::Base
  has_many :answers
  belongs_to :exercise
  accepts_nested_attributes_for :answers

  validates :text, presence: true
end
