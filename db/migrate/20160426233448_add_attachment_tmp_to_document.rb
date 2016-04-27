class AddAttachmentTmpToDocument < ActiveRecord::Migration
  def change
    # More info: github.com/lardawge/carrierwave_backgrounder#to-use-store_in_background
    add_column :documents, :attachment_tmp, :string
  end
end
