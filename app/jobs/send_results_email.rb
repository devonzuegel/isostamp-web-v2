class SendResultsEmail < Que::Job
  def run(te_id)
    te = TagfinderExecution.find(te_id)
    TagfinderResultMailer.sample_email(te).deliver_now
    te.update_attributes!(email_sent: Time.now)
  end
end