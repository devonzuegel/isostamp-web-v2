class TagfinderResultMailer < ApplicationMailer
  default from: ENV['EMAIL_SENDER']

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end
end
