class MyJobOpportunitiesController < ApplicationController
  def create
    job_opportunity = JobOpportunity.find(params[:job_opportunity_id])
    if job_opportunity.my_job_opportunities.find_by(user: user_session.current_user).present?
      flash[:notice] = "You already added this job."
      return redirect_to '/job_opportunities'
    end
    if job_opportunity.my_job_opportunities.create(user: user_session.current_user)
      flash[:notice] = "You have successfully added this job to your dashboard"
    else
      flash[:notice] = "Sorry, something went wrong. The job wasn't added."
    end
    redirect_to '/job_opportunities'
  end
end