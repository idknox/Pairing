class PreTestQuestionsController < ApplicationController

  def show
    @question = PreTestQuestion.find(params[:question_id])
    @cohort = Cohort.find(params[:cohort_id])
    all_answers = PreTestAnswer.for_cohort_and_question(@cohort, @question)
    @submitted_answers, @unsubmitted_answers = all_answers.partition { |answer| answer.pre_test.submitted? }
    @next_path = next_path
  end

  def assess
    @question = PreTestQuestion.find(params[:question_id])
    @cohort = Cohort.find(params[:cohort_id])

    params[:pretest_answer].each do |answer_id, status|
      PreTestAnswer.update(answer_id, status: status)
    end

    redirect_to next_path
  end

  def next_path
    next_question = PreTestQuestion.question_after(@question)
    if next_question
      cohort_pretest_question_path(@cohort, next_question)
    else
      cohort_pretest_path(@cohort)
    end
  end

end