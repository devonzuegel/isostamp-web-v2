class RunExecution < Que::Job
  MAX_NUM_ATTEMPTS = 2
  @retry_interval  = 5

  def run(te_id)
    execution = TagfinderExecution.find(te_id)
    if execution.num_attempts >= MAX_NUM_ATTEMPTS
      execution.update_attributes(success: false)
    else
      execution.increment!(:num_attempts)
      execution.log("Beginning execution #{te_id} (Attempt ##{execution.num_attempts})")

      unless execution.success.nil?
        execution.log("Clearing 'success' attribute on execution ##{execution.id}")
        execution.update_attributes(success: nil)
      end

      execution.run
    end

    execution.log("Sending email for #{te_id}...")
    SendResultsEmail.enqueue(te_id, run_at: 10.seconds.from_now)
    destroy
  end
end
