FindUserFromGithubInfo = ->(github_info) do
  User.find_by(email: github_info['email']) || User.find_by(github_id: github_info['id'])
end