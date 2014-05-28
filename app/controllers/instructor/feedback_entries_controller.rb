class Instructor::FeedbackEntriesController < ::BaseFeedbackEntriesController
  def index
    @presenter = FeedbackEntryIndexPresenter.new(user_session.current_user)
    @users_for_filter = all_users_ordered
    @selected_user_id = params['feedback_for_student']
  end

  def success_path
    instructor_cohort_feedback_entries_path(params[:cohort_id])
  end

  def all_users_ordered
    cohort = Cohort.find(params[:cohort_id])
    
    cohort.students.order('first_name ASC') - [user_session.current_user]
  end
end