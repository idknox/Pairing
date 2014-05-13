module Students
  class AssignmentsController < SignInRequiredController
    def index
      user = user_session.current_user

      @assignments = user.cohort_assignments.map do |assignment|
        StudentCohortAssignment.new(user.id, assignment)
      end
    end
  end

  class StudentCohortAssignment
    def initialize(user_id, assignment)
      @user_id = user_id
      @assignment = assignment
    end

    delegate :name, :to_param, to: :assignment

    def completed?
      assignment.completed_by?(user_id) ? "completed" : "incomplete"
    end

    private

    attr_reader :assignment, :user_id
  end
end
