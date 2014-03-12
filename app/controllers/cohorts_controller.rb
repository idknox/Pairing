class CohortsController < SignInRequiredController

  before_action :signed_in?

  def index
    @cohorts = Cohort.all
  end

  def show
    students = User.for_cohort(params[:id])
    render 'show',
           locals: {
               students: students,
               lucky_winner: students.sample
           }
  end

  def one_on_ones
    students = User.for_cohort(params[:id])
    all_instructors = User.instructors
    selected_instructors = if params[:instructor_ids]
      all_instructors.select { |instructor| params[:instructor_ids].include?(instructor.id.to_s) }
    else
      all_instructors
    end
    scheduler = OneOnOneScheduler.new(students, selected_instructors)
    scheduler.generate_schedule
    render 'one_on_ones',
      locals: {
        appointments: scheduler.appointments,
        unscheduled_students: scheduler.unscheduled_students,
        all_instructors: all_instructors,
        selected_instructors: selected_instructors,
      }
  end

  protected

  def signed_in?
    unless user_session.current_user.is?(User::INSTRUCTOR)
      redirect_to root_path
    end
  end

end