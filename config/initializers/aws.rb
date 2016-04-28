# Rails.configuration.aws is used by AWS, Paperclip, and S3DirectUpload
Rails.configuration.aws = {
  access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],
  bucket:             ENV['AWS_S3_BUCKET']
}
AWS.config(logger: Rails.logger)
AWS.config(Rails.configuration.aws)