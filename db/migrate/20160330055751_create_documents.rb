class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string     :name
      t.string     :attachment
      t.string     :format
      t.references :user

      t.timestamps null: false
    end
  end
end
