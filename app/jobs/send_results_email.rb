class SendResultsEmail < Que::Job
  @retry_interval = 5

  def run(te_id)
    te = TagfinderExecution.find(te_id)
    TagfinderResultMailer.sample_email(te).deliver_now
  end
end