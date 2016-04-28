CarrierWave.configure do |config|
  # If you encounter a 403 Forbidden error, follow the directions here:
  #   stackoverflow.com/questions/28564653/exconerrorsforbidden-expected200-actual403-forbidden
  #
  # For information on AWS bucket regions:
  #   bucketexplorer.com/documentation/amazon-s3--amazon-s3-buckets-and-regions.html

  config.cache_dir = "#{Rails.root}/tmp/uploads"

  config.fog_credentials = {
    provider:               'AWS',                        # required
    aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],     # required
    aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'], # required
    region:                 ENV['AWS_BUCKET_REGION'],
    host:                   "s3-#{ENV['AWS_BUCKET_REGION']}.amazonaws.com",
  }

  config.fog_directory = ENV['AWS_S3_BUCKET']
  config.fog_public    = false
end
