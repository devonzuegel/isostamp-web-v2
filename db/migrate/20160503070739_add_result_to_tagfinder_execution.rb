class AddResultToTagfinderExecution < ActiveRecord::Migration
  def change
    add_column :tagfinder_executions, :result, :string
  end
end
