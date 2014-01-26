InviteStudent = ->(first_name, last_name, email, cohort) do
  User.create!(first_name: first_name, last_name: last_name, email: email, cohort_id: cohort.id)
  StudentMailer.invitation(email).deliver
end