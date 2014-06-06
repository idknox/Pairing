class Instructor::AttendanceController < InstructorRequiredController
  def new
    @cohort = user_session.current_user.cohort
    @students = @cohort.students
  end

  def create
    students = params[:attendance][:students]
    cohort = user_session.current_user.cohort

    attendance_sheet = AttendanceSheet.create(sheet_date: Date.today, cohort_id: cohort.id)

    students.each do |_, student|
      Attendance.create(
        user_id: student[:student_id],
        attendance_sheet_id: attendance_sheet.id,
        in_class: student[:in_class]
      )
    end

    redirect_to instructor_cohort_path(cohort), notice: "Attendance successfully submitted"
  end
end