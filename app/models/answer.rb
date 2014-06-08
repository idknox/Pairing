class Answer < ActiveRecord::Base
  belongs_to :comprehension_question
  validates :text, presence: true
end
