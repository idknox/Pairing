require "rails_helper"

describe Question do
  describe ".for_cohort" do
    it "returns questions for the given cohort" do
      cohort_question_why = Question.create!(text: "why?", cohort_id: 1)
      cohort_question_how = Question.create!(text: "how?", cohort_id: 1)
      different_cohort_question = Question.create!(text: "hello there", cohort_id: 2)

      expect(Question.for_cohort(1)).to match_array([cohort_question_why, cohort_question_how])
    end
  end
end
