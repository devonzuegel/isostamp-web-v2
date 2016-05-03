require 'open3'

class RunExecution < Que::Job
  def run(te_id)
    execution = TagfinderExecution.find(te_id)
    ap execution
    ActiveRecord::Base.transaction do
        execution.run
        destroy
    end
  end
end