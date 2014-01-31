module ObjectFactories

  def create_user(overrides = {})
    new_user(overrides).tap do |u|
      u.save!
    end
  end

  def new_user(overrides = {})
    defaults = {
        email: "user#{rand}@example.com"
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

    }
    FeedbackEntry.new(defaults.merge(overrides))
  end
end