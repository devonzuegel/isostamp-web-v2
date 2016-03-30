class DataUpload < ActiveRecord::Base
  # Relationships
  belongs_to :user

  # Constants
  FORMATS = %w(mzXML)
end
