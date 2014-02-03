require 'github/markup/markdown'

class FeedbackEntriesController < SignInRequiredController
  def index
    render 'index', locals: {
        presenter: FeedbackEntryIndexPresenter.new(user_session.current_user),
        users_for_filter: User.all,
        selected_user_id: params['feedback_for_student']
    }
  end

  def new
    render_new(FeedbackEntry.new, users_that_can_be_given_feedback)
  end

  def create
    recipient_id = params['feedback_entry']['recipient_id']
    comment = params['feedback_entry']['comment']

    use_case = GiveFeedback.new(User.find(recipient_id), user_session.current_user, comment)

    use_case.success(->(_) {
      redirect_to feedback_path, :notice => t('feedback.success')
    })

    use_case.failure(->(feedback_entry) {
      flash[:error] = t('feedback.error')
      render_new(feedback_entry, users_that_can_be_given_feedback)
    })

    use_case.run!
  end

  def show
    feedback_entry = ViewFeedback.new(user_session.current_user, params['id']).run!
    render 'show', locals: {
        renderer: GitHub::Markup::Markdown.new ,
        feedback_entry: feedback_entry
    }
  end

  private

  def users_that_can_be_given_feedback
    User.all
  end

  def render_new(entry, users)
    render 'new',
           locals: {
               feedback_entry: entry,
               users_that_can_be_given_feedback: users
           }
  end
end