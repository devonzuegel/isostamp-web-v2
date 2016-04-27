# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay

  storage :fog

  def store_dir
    "#{model.class.to_s.pluralize.underscore}/#{model.id}"
  end

  def extension_white_list
    Document::EXTENSION_WHITE_LIST
  end
end
