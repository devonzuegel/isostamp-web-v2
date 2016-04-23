class Document < ActiveRecord::Base
  # Relationships
  belongs_to :user

  # Uploaders
  mount_uploader :attachment, MzxmlUploader

  def filename
    File.basename(attachment.path || '')
  end
end
