class Question < ActiveRecord::Base

  validates :text, presence: true

  def self.for_cohort(cohort_id)
    where(cohort_id: cohort_id)
  end

end
