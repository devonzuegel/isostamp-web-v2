# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "#{model.class.to_s.pluralize.underscore}/#{model.id}"
  end

  def extension_white_list
    DataUpload::FORMATS
  end
end
