class AddResultToTagfinderExecution < ActiveRecord::Migration
  def change
    add_column :tagfinder_executions, :stdouts,  :string
    add_column :tagfinder_executions, :stderrs,  :string
  end
end
