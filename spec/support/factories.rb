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
end