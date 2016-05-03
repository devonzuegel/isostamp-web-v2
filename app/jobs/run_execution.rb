require 'open3'

class RunExecution < Que::Job
  def run(te_id)
    ActiveRecord::Base.transaction do
        execution = TagfinderExecution.find(te_id)
        execution.run
        destroy
    end
  end
end