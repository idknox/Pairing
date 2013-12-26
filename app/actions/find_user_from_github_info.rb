FindUserFromGithubInfo = ->(github_info) do
  user = nil
  if github_info['email'].present?
    user = User.find_by(email: github_info['email'])
  end
  user ||= if github_info['id'].present?
    User.find_by(github_id: github_info['id'])
  end
  user
end