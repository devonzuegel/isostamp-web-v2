# Preview all emails at http://localhost:3000/rails/mailers/tagfinder_result_mailer
class TagfinderResultMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    TagfinderResultMailer.sample_email(TagfinderExecution.new(
      user:        User.first,
      created_at:  3.days.ago,
      data_file:   Document.first,
      result:      'TEST RESULT!'
    ))
  end
end
