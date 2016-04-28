S3DirectUpload.config do |c|
  c.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
  c.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  c.bucket            = ENV['AWS_S3_BUCKET']
  c.region            = ENV['AWS_BUCKET_REGION']
  c.url               = "https://#{c.bucket}.s3-#{c.region}.amazonaws.com/"
end