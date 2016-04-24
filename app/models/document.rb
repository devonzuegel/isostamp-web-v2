class Document < ActiveRecord::Base
  # Relationships
  belongs_to :user

  # Uploaders
  mount_uploader :attachment, MzxmlUploader
  enum kind: { 'Mass Spec Data': 0, 'Params': 1 }

  def filename
    File.basename(attachment.path || '')
  end
end
