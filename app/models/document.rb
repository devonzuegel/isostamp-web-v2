class Document < ActiveRecord::Base
  # Relationships
  belongs_to :user

  # Uploaders
  mount_uploader :attachment, MzxmlUploader

  # Validations
  validates_presence_of :name, :attachment

  # Constants
  FORMATS = %w(mzXML)

  def attachment_url
    "/uploads/#{self.class.to_s.pluralize.underscore}/#{id}/#{name}"
  end
end
