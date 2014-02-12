require 'spec_helper'

describe PreTestAnswer do
  
  describe '.for_cohort_and_question' do
    
    it 'returns answers from users in the given cohort for the given question' do
      cohort = Cohort.create(name: "foobar")
      question = PreTestQuestion.create!(text: "Write a Ruby class")
      question2 = PreTestQuestion.create!(text: "Write a Ruby module")

      student_in_cohort = create_user first_name: 'Student', last_name: '1', cohort: cohort
      pretest1 = PreTest.create!(user: student_in_cohort)
      answer_in_cohort_and_question1 = PreTestAnswer.create!(pre_test: pretest1, question: question, answer_text: "I am correct")

      student_in_cohort2 = create_user first_name: 'Student', last_name: '2', cohort: cohort
      pretest2 = PreTest.create!(user: student_in_cohort2)
      answer_in_cohort_and_question2 = PreTestAnswer.create!(pre_test: pretest2, question: question, answer_text: "I am incorrect")

      student_in_cohort2 = create_user first_name: 'Student', last_name: '2', cohort: cohort
      pretest2 = PreTest.create!(user: student_in_cohort2)
      PreTestAnswer.create!(pre_test: pretest2, question: question2, answer_text: "I am incorrect")

      student_not_in_cohort = create_user first_name: 'Student', last_name: '2'
      pretest2 = PreTest.create!(user: student_not_in_cohort)
      PreTestAnswer.create!(pre_test: pretest2, question: question, answer_text: "I am incorrect")
      
      result = PreTestAnswer.for_cohort_and_question(cohort, question)
      
      expect(result).to match_array([answer_in_cohort_and_question1, answer_in_cohort_and_question2])
    end
    
  end
  
end