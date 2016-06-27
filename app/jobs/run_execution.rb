class RunExecution < Que::Job
  @retry_interval = 5

  def run(te_id)
    execution = TagfinderExecution.find(te_id)
    execution.increment(:num_attempts)
    execution.log("Running execution #{te_id}...")

    execution.log("Clearing 'success' attribute on execution ##{execution.id}...")
    execution.update_attributes(success: nil)

    # ActiveRecord::Base.transaction do
    execution.run

    if execution.successful?
      execution.log('SUCCESS')
      execution.log("Uploading results files for #{te_id}...")
      UploadResultsFilesToS3.enqueue(te_id)
    else
      execution.log("FAILURE")
    end

    execution.log("Sending email for #{te_id}...")
    SendResultsEmail.enqueue(te_id, run_at: 10.seconds.from_now)
    destroy
    # end
  end
end