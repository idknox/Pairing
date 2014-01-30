class FeedbackMailer < ActionMailer::Base
  default from: 'instructors@gschool.it'

  def feedback_received(recipient_email, entry_id, provider_name)
    @entry_id = entry_id
    @provider_name = provider_name
    mail(
        to: recipient_email,
        subject: I18n.t('feedback_mailer.feedback_received.subject')
    )
  end
end