class ResultsFile < ActiveRecord::Base
  belongs_to :tagfinder_execution

  validates_presence_of *%i[tagfinder_execution filename]

  def upload_complete?
    !direct_upload_url.nil?
  end
end
