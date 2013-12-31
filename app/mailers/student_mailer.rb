class StudentMailer < ActionMailer::Base
  default from: 'instructors@gschool.it', bcc: 'kirsten@galvanize.it'

  def invitation(email)
    mail(to: email, subject: 'Welcome to the gSchool student portal')
  end
end