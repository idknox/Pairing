require 'github/markdown'

class BaseFeedbackEntriesController < SignInRequiredController

  def new
    render_new(FeedbackEntry.new, all_users_ordered)
  end

  def create
    recipient_id = params['feedback_entry']['recipient_id']
    comment = params['feedback_entry']['comment']

    use_case = GiveFeedback.new(User.find(recipient_id), user_session.current_user, comment)

    use_case.success(->(_) {
      redirect_to success_path, :notice => t('feedback.success')
    })

    use_case.failure(->(feedback_entry) {
      flash[:error] = t('feedback.error')
      render_new(feedback_entry, all_users_ordered)
    })

    use_case.run!
  end

  def show
    feedback_entry = ViewFeedback.new(user_session.current_user, params['id']).run!

    render 'base_feedback_entries/show', locals: {
        renderer: GitHub::Markdown ,
        feedback_entry: feedback_entry
    }
  end

  private

  def success_path
    raise "Abstract: not implemented"
  end

  def all_users_ordered
    raise "Abstract: not implemented"
  end


  def render_new(entry, users)
    @feedback_entry = entry
    @users_that_can_be_given_feedback = users
    render "base_feedback_entries/new"
  end
end