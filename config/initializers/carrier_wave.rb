CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:               'AWS',                        # required
    aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],     # required
    aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'], # required
    region:                 ENV['AWS_BUCKET_REGION'],
    host:                   "s3-#{ENV['AWS_BUCKET_REGION']}.amazonaws.com",
  }

  config.fog_directory  = ENV['AWS_S3_BUCKET']
end
