class CreateHistoryOutputs < ActiveRecord::Migration
  def change
    create_table :history_outputs do |t|
      t.text :command
      t.integer :status
      t.references :tagfinder_execution, index: true, foreign_key: true
      t.text :stderr
      t.text :stdout

      t.timestamps null: false
    end
  end
end
