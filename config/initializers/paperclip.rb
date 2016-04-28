bucket = ENV['AWS_S3_BUCKET']
region = ENV['AWS_BUCKET_REGION']

Paperclip::Attachment.default_options.merge!(
  url:             "https://#{bucket}.s3-#{region}.amazonaws.com/",
  path:            ':class/:attachment/:id/:style/:filename',
  storage:         :s3,
  s3_credentials:  Rails.configuration.aws,
  s3_permissions:  :private,
  s3_protocol:     'https'
)