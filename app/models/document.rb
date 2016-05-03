
class Document < ActiveRecord::Base
  # Environment-specific direct upload url verifier screens for malicious posted upload locations.
  DIRECT_UPLOAD_URL_FORMAT = %r{
    \Ahttps\:\/\/#{ENV['AWS_S3_BUCKET']}\.s3-#{ENV['AWS_BUCKET_REGION']}\.amazonaws\.com\/
    (?<path>uploads\/.+\/(?<filename>.+))\z
  }x.freeze

  belongs_to :user
  has_attached_file :upload

  validates_presence_of :user
  validates :direct_upload_url, presence: true, format: { with: DIRECT_UPLOAD_URL_FORMAT }

  before_create :set_upload_attributes
  after_destroy :delete_s3_file

  # Store an unescaped version of the escaped URL that Amazon returns from direct upload.
  def direct_upload_url=(escaped_url)
    write_attribute(:direct_upload_url, CGI.unescape(escaped_url))
  end

  protected

  # Set attachment attributes from the direct upload
  # @note Retry logic handles S3 "eventual consistency" lag.
  def set_upload_attributes
    tries ||= 5
    s3 = AWS::S3.new
    direct_upload_head = s3_file.head

    self.upload_file_name     = direct_upload_url_data[:filename]
    self.upload_file_size     = direct_upload_head.content_length
    self.upload_content_type  = direct_upload_head.content_type
    self.upload_updated_at    = direct_upload_head.last_modified
  rescue AWS::S3::Errors::NoSuchKey => e
    tries -= 1
    if tries > 0
      sleep(3)
      retry
    else
      false
    end
  end

  def direct_upload_url_data
    DIRECT_UPLOAD_URL_FORMAT.match(direct_upload_url)
  end

  def delete_s3_file
    s3_file.delete
  end

  def s3_file
    s3_bucket = AWS::S3.new.buckets[Rails.configuration.aws[:bucket]]
    s3_bucket.objects[direct_upload_url_data[:path]]
  end
end