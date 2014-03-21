class JobOpportunitiesController < ApplicationController
  def index
    job_opportunities = JobOpportunity.all
    render :index, locals: {job_opportunities: job_opportunities}
  end

  def create
    job_parameters = params.require(:job_opportunity).permit!
    job_opportunity = JobOpportunity.new(job_parameters)
    if job_opportunity.save
      flash[:notice] = 'Job Opportunity Successfully Created'
    else
      flash[:notice] = 'Sorry, something went wrong!'
    end
    redirect_to action: :index
  end
end