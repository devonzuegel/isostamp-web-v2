class Document < ActiveRecord::Base
  # Relationships
  belongs_to :user

  # Uploaders
  mount_uploader :attachment, MzxmlUploader

  # Validations
  validates_presence_of :name
end
