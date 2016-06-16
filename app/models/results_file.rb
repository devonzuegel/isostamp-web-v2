class ResultsFile < ActiveRecord::Base
  belongs_to :tagfinder_execution

  validates_presence_of *%i(tagfinder_execution tmp_filepath filename hex_base)
  validate :tmp_file_exists

  def upload_complete?
    !direct_upload_url.nil?
  end

  def s3_key
    "results/#{hex_base}/#{filename}"
  end

  private

  def tmp_file_exists
    if tmp_filepath.nil?
      errors.add(:tmp_filepath, "must not be blank")
    elsif !File.file?(tmp_filepath)
      errors.add(:tmp_filepath, "must refer to an existing, non-directory file. '#{tmp_filepath}' does not exist.")
    end
  end
end
