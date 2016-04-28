S3DirectUpload.config do |c|
  c.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
  c.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  c.bucket            = ENV['AWS_S3_BUCKET']

  # Required non-default AWS regions, eg. "s3-eu-west-1"
  c.region            = ENV['AWS_BUCKET_REGION']

  # S3 API endpoint (optional), eg. "https://#{c.bucket}.s3.amazonaws.com/"
  c.url               = "s3-#{ENV['AWS_BUCKET_REGION']}.amazonaws.com"
end