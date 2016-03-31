# encoding: utf-8

class MzxmlUploader < CarrierWave::Uploader::Base
  storage :s3

  def store_dir
    # #{Rails.root}/private
    "uploads/#{model.class.to_s.pluralize.underscore}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def extension_white_list
    %w(mzXML)
  end
end
