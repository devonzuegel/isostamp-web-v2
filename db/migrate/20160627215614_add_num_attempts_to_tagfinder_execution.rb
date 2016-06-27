class AddNumAttemptsToTagfinderExecution < ActiveRecord::Migration
  def change
    add_column :tagfinder_executions, :num_attempts, :integer, default: 0
  end
end
