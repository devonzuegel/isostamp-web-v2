module DataAndParamsAttachable
  extend ActiveSupport::Concern

  # PARAMS

  def used_default_params?
    params_file_id.nil?
  end

  def params_file_removed?
    params_file.nil? && !params_file.nil?
  end

  def params_filename(with_extension: true)
    filename(params_file.upload_file_name, with_extension)
  end

  def params_file_url
    params_file.direct_upload_url
  end

  def tmp_params_filepath
    "./tmp/#{hex_base}-#{File.basename(params_file_url)}"
  end

  # DATA

  def data_file_removed?
    data_file.nil? && !data_file_id.nil?
  end

  def data_filename(with_extension: true)
    filename(data_file.upload_file_name, with_extension)
  end

  def data_file_url
    data_file.direct_upload_url
  end

  def tmp_data_filepath
    "./tmp/#{hex_base}-#{File.basename(data_file_url)}"
  end

  def files_have_been_removed?
    if params_file_removed?
      log <<~HEREDOC
        Error: The parameters file #{params_filename}
        required for this execution has been removed
        HEREDOC
      return true
    end

    if data_file_removed?
      log <<~HEREDOC
      Error: The parameters file #{params_filename}
      required for this execution has been removed
      HEREDOC
      return true
    end

    false
  end

  private

  def filename(full_name, with_extension = true)
    with_extension ? full_name : File.basename(full_name, File.extname(full_name))
  end
end
