class PreTestQuestionsController < ApplicationController

  def show
    @question = PreTestQuestion.find(params[:question_id])
    @cohort = Cohort.find(params[:cohort_id])
    @answers = PreTestAnswer.for_cohort_and_question(@cohort, @question)
  end

end