class SendResultsEmail < Que::Job
  def run(te_id)
    execution = TagfinderExecution.find(te_id)
    TagfinderResultMailer.sample_email(execution).deliver_now
  end
end