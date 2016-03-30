class DataUpload < ActiveRecord::Base
  # Relationships
  belongs_to :user

  # Uploaders
  mount_uploader :attachment, AttachmentUploader

  # Validations
  validates_presence_of :name

  # Constants
  FORMATS = %w(mzXML)
end
