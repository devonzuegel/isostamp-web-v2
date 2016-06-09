class RunExecution < Que::Job
  def run(te_id)
    setup_error_handler

    ActiveRecord::Base.transaction do
        execution = TagfinderExecution.find(te_id)
        execution.run

        # TODO alert user of completion

        destroy
    end
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