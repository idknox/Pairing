class MyJobOpportunitiesController < ApplicationController
  def create
    job_opportunity = JobOpportunity.find(params[:job_opportunity_id])
    if job_opportunity.my_job_opportunities.create(user: user_session.current_user)
      flash[:notice] = "You have successfully added this job to your dashboard"
    else
      flash[:notice] = "Sorry, something went wrong. The job wasn't added."
    end
    redirect_to '/job_opportunities'
  end
end