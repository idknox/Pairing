class FindUserFromGithubInfo
  def self.call(github_info)
    find_by_email(github_info) || find_by_github_id(github_info)
  end

  private

  def self.find_by_email(github_info)
    return unless github_info['email'].present?

    User.find_by(email: github_info['email'].downcase)
  end

  def self.find_by_github_id(github_info)
    return unless github_info['id'].present?

    User.find_by(github_id: github_info['id'])
  end
end