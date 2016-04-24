class AddKindToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :kind, :integer, null: false
  end
end
