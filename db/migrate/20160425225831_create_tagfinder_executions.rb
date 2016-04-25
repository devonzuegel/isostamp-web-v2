class CreateTagfinderExecutions < ActiveRecord::Migration
  def change
    create_table :tagfinder_executions do |t|
      t.references :user,        index: true, foreign_key: true, null: false
      t.belongs_to :data_file,   index: true, null: false
      t.belongs_to :params_file, index: true
      t.boolean    :email_sent
      t.boolean    :success

      t.timestamps null: false
    end
  end
end
