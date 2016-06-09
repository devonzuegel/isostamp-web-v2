# Preview all emails at http://localhost:3000/rails/mailers/tagfinder_result_mailer
class TagfinderResultMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    TagfinderResultMailer.sample_email(User.first)
  end
end
