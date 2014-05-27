class Student::ExercisesController < SignInRequiredController
  def index
    user = user_session.current_user

    @exercises = user.cohort_exercises.map do |exercise|
      StudentCohortExercise.new(user.id, exercise)
    end
  end
end

class StudentCohortExercise
  def initialize(user_id, exercise)
    @user_id = user_id
    @exercise = exercise
  end

  delegate :name, :to_param, to: :exercise

  def completed?
    exercise.completed_by?(user_id) ? "completed" : "incomplete"
  end

  private

  attr_reader :exercise, :user_id
end
