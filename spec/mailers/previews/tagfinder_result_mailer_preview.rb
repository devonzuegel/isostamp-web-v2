# Preview all emails at http://localhost:3000/rails/mailers/tagfinder_result_mailer
class TagfinderResultMailerPreview < ActionMailer::Preview
  def preview
    TagfinderResultMailer.sample_email(TagfinderExecution.last, preview: true)
  end
end
