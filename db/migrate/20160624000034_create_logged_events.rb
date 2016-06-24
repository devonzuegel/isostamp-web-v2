class CreateLoggedEvents < ActiveRecord::Migration
  def change
    create_table :logged_events do |t|
      t.references :tagfinder_execution, index: true, foreign_key: true
      t.text :log

      t.timestamps null: false
    end
  end
end
