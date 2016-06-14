class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.attachment :upload
      t.string     :direct_upload_url, null: false
      t.boolean    :processed,         null: false, default: false
      t.timestamps                     null: false

      t.references :user, null: false
    end

    add_index :documents, :user_id
    add_index :documents, :processed
  end
end
