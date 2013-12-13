class StudentMailer < ActionMailer::Base
  default from: 'info@gschool.it'

  def invitation(email)
    mail(to: email, subject: 'Welcome to the gSchool student portal')
  end
end