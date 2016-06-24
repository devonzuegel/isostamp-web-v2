class RunExecution < Que::Job
  @retry_interval = 5

  def run(te_id)
    execution = TagfinderExecution.find(te_id)

    ActiveRecord::Base.transaction do
      execution.log("Running execution #{te_id}...")
      execution.run

      if execution.successful?
        execution.log('SUCCESS!!!!!!!!!!')
        execution.log("Uploading results files for #{te_id}...")
        UploadResultsFilesToS3.enqueue(te_id)
      else
        execution.log("FAILED results files for #{te_id}...")
      end

      execution.log("Sending email for #{te_id}...")
      SendResultsEmail.enqueue(te_id, run_at: 10.seconds.from_now)
      destroy
    end
  end
end