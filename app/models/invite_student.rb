InviteStudent = ->(first_name, last_name, email) do
  user = User.find_by(email: email)
  if user.nil?
    User.create!(first_name: first_name, last_name: last_name, email: email)
    StudentMailer.invitation(email).deliver
  end
end