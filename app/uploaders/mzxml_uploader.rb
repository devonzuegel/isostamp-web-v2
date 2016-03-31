# encoding: utf-8

class MzxmlUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.pluralize.underscore}/#{model.id}"
  end

  def extension_white_list
    %w(mzXML)
  end
end
