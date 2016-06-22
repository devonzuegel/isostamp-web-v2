class RunExecution < Que::Job
  def run(te_id)
    execution = TagfinderExecution.find(te_id)

    ActiveRecord::Base.transaction do
      execution.run
      destroy
    end
  end
end