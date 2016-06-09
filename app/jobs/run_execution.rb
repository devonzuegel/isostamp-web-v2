class RunExecution < Que::Job
  def run(te_id)
    setup_error_handler

    ActiveRecord::Base.transaction do
      execution = TagfinderExecution.find(te_id)
      execution.run

      TagfinderResultMailer.sample_email(execution).deliver_now
      Que.log "Email to #{execution.user.email} regarding execution ##{execution.id} sent"
    end
    destroy
  end

  def setup_error_handler
    Que.error_handler = proc do |error, job|
      puts '------------------------------------------'.red
      puts 'ERROR:'.black
      ap error
      puts 'JOB:'.black
      ap job
      puts '------------------------------------------'.red
    end
  end
end