class Document < ActiveRecord::Base
  # Relationships
  belongs_to :user

  # Uploaders
  mount_uploader :attachment, AttachmentUploader

  # Validations
  validates_presence_of :name, :attachment

  # Constants
  FORMATS = %w(mzXML)

  def attachment_url
    "#{self.class.to_s.pluralize.underscore}/#{id}/#{name}"
  end
end
