class CreateResultsFiles < ActiveRecord::Migration
  def change
    create_table :results_files do |t|
      t.references :tagfinder_execution, null: false, index: true, foreign_key: true
      t.string :direct_upload_url,       null: false
      t.string :upload_file_name,        null: false

      t.timestamps null: false
    end
  end
end
