class RunExecution < Que::Job
  @retry_interval = 5

  def run(te_id)
    execution = TagfinderExecution.find(te_id)

    ActiveRecord::Base.transaction do
      puts "Running execution #{te_id}...".yellow
      execution.run

      if execution.successful?
        puts "Uploading results files for #{te_id}...".yellow
        UploadResultsFilesToS3.enqueue(te_id)
      else
        puts "FAILED results files for #{te_id}...".yellow
      end

      puts "Sending email for #{te_id}...".yellow
      SendResultsEmail.enqueue(te_id)
      destroy
    end
  end
end