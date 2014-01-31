require 'github/markup/markdown'

class FeedbackEntriesController < SignInRequiredController
  def index
    render 'index', locals: {
        my_feedback_entries: feedback_entries_for(user_session.current_user),
        users_for_filter: User.all,
        selected_feedback_entries: selected_feedback_entries(params['feedback_for_student']),
        current_user: user_session.current_user
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
    render 'show', locals: {
        renderer: GitHub::Markup::Markdown.new ,
        feedback_entry: entry_to_show(user_session.current_user, params['id'])
    }
  end

  private

  def feedback_entries_for(user)
    FeedbackEntry.given_to(user).order('created_at desc')
  end

  def users_that_can_be_given_feedback
    User.all
  end

  def selected_feedback_entries(id)
    id.nil? ? FeedbackEntry.none : FeedbackEntry.given_to(User.find(id))
  end

  def entry_to_show(current_user, entry_id)
    current_user.is?(User::INSTRUCTOR) ? FeedbackEntry.find(entry_id) : FeedbackEntry.given_to(user_session.current_user).find(entry_id)
  end

  def render_new(entry, users)
    render 'new',
           locals: {
               feedback_entry: entry,
               users_that_can_be_given_feedback: users
           }
  end
end