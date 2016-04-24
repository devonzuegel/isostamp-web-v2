class Document < ActiveRecord::Base
  # Relationships
  belongs_to :user

  # Uploaders
  mount_uploader :attachment, MzxmlUploader
  enum kind: { mass_spec_data: 0, params: 1 }

  def filename
    File.basename(attachment.path || '')
  end
end
