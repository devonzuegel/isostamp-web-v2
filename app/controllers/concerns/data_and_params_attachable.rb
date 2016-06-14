module DataAndParamsAttachable
  extend ActiveSupport::Concern

  def used_default_params?
    params_file_id.nil?
  end

  def params_file_removed?
    !used_default_params? && params_file.nil?
  end

  def data_file_removed?
    data_file.nil? && !data_file_id.nil?
  end

  def data_filename(with_extension: true)
    filename = data_file.upload_file_name
    with_extension ? filename : File.basename(filename,File.extname(filename))
  end

  def data_file_url
    data_file.direct_upload_url
  end

  private
end