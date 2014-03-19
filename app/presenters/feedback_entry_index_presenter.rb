class FeedbackEntryIndexPresenter
  def initialize(user)
    @user = user
  end

  def can_view_other_feedback?
    user.is?(User::INSTRUCTOR)
  end

  def my_feedback_entries
    FeedbackEntry.given_to(user).order('created_at desc')
  end

  def given_feedback_entries
    FeedbackEntry.given_by(user).order('created_at desc')
  end

  def feedback_entries_for_another_user(user_id)
    if (user_id.nil? || !can_view_other_feedback?)
      FeedbackEntry.none
    else
      FeedbackEntry.given_to(User.find(user_id))
    end
  end

  private
  attr_reader :user
end