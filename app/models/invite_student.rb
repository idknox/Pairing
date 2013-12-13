InviteStudent = ->(first_name, last_name, email) do
    User.create!(first_name: first_name, last_name: last_name, email: email)
    StudentMailer.invitation(email).deliver
end