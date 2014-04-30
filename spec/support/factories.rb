module ObjectFactories

  def create_instructor_user(overrides = {})
    create_user(overrides).tap do |u|
      u.add_role(User::INSTRUCTOR)
      u.save!
    end
  end

  def create_user(overrides = {})
    new_user(overrides).tap do |u|
      u.save!
    end
  end

  def new_user(overrides = {})
    defaults = {
        email: "user#{rand}@example.com",
        first_name: 'John',
        last_name: 'Smith'
    }
    User.new(defaults.merge(overrides))
  end

  def create_feedback_entry(overrides = {})
    new_feedback_entry(overrides).tap do |fe|
      fe.save!
    end
  end

  def new_feedback_entry(overrides = {})
    defaults = {
      comment: "Great job!"
    }
    FeedbackEntry.new(defaults.merge(overrides))
  end

  def create_quiz(overrides = {})
    new_quiz(overrides).tap do |fe|
      fe.save!
    end
  end

  def new_quiz(overrides = {})
    defaults = {
        status: Assessments::Quiz::SUBMITTED
    }
    Assessments::Quiz.new(defaults.merge(overrides))
  end

  def create_cohort(overrides = {})
    new_cohort(overrides).tap do |c|
      c.save!
    end
  end

  def new_cohort(overrides = {})
    defaults = {
        name: "gSchool#{rand(1000)}",
        directions: "<p>Some directions</p>",
        google_maps_location: 'https://google.com'
    }
    Cohort.new(defaults.merge(overrides))
  end

  def create_job_opportunity

  end
end
