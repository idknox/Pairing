class FeedbackEntriesController < SignInRequiredController
  def index
    render 'index', locals: {feedback_entries: FeedbackEntry.given_to(user_session.current_user)}
  end

  def new
    render 'new', locals: {
        feedback_entry: FeedbackEntry.new,
        users_that_can_be_given_feedback: users_that_can_be_given_feedback
    }
  end

  def create
    recipient_id = params['feedback_entry']['recipient_id']
    comment = params['feedback_entry']['comment']

    use_case = GiveFeedback.new(User.find(recipient_id), user_session.current_user, comment)

    use_case.success(->(_) { redirect_to feedback_path, :notice => t('feedback.success') })
    use_case.failure(->(feedback_entry) {
      flash[:error] = t('feedback.error')
      render 'new',
             locals: {
                 feedback_entry: feedback_entry,
                 users_that_can_be_given_feedback: users_that_can_be_given_feedback
             }
    })

    use_case.run!
  end

  def show
    render 'show', locals: {feedback_entry: FeedbackEntry.given_to(user_session.current_user).find(params['id'])}
  end

  private

  def users_that_can_be_given_feedback
    User.all
  end
end