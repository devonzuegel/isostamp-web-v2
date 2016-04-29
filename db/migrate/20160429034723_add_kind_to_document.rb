class AddKindToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :kind, :integer
  end
end
