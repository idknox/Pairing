class Student::FeedbackEntriesController < ::BaseFeedbackEntriesController
  def index
    user = user_session.current_user

    @my_feedback_entries = FeedbackEntry.given_to(user).order('created_at desc')
    @given_feedback_entries = FeedbackEntry.given_by(user).order('created_at desc')

    @users_for_filter = all_users_ordered
    @selected_user_id = params['feedback_for_student']
  end

  def success_path
    student_feedback_entries_path
  end

  def all_users_ordered
    user_session.current_cohort.students.order('first_name ASC') - [user_session.current_user]
  end
end