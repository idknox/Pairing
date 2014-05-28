class Instructor::FeedbackEntriesController < ::BaseFeedbackEntriesController
  def index
    @users_for_filter = all_users_ordered
    @feedback_entries = FeedbackEntry.given_to(params['feedback_for_student'])
  end

  def success_path
    instructor_cohort_feedback_entries_path(params[:cohort_id])
  end

  def all_users_ordered
    cohort = Cohort.find(params[:cohort_id])

    cohort.students.order('first_name ASC') - [user_session.current_user]
  end
end