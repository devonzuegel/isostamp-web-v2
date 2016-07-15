module DataAndParamsAttachable
  extend ActiveSupport::Concern

  DEFAULT_PARAMS_FILE = 'https://s3-us-west-2.amazonaws.com/isostamp-production/default_config.txt?X-Amz-Date=20160715T002440Z&X-Amz-Expires=300&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Signature=c0a3cf4bc620503b318525e0bfd9c719bb37db7b73adcea58a15cf0be3ffd48d&X-Amz-Credential=ASIAI6LCNMN5CLX56TVA/20160715/us-west-2/s3/aws4_request&X-Amz-SignedHeaders=Host&x-amz-security-token=FQoDYXdzEID//////////wEaDFqvAJVuRdE0FSL6FiLHAeUbUa0Lz5Dz0LTZdM8Xq6rZUyWHtSeaZYjmVRanRim6VX08G1LATIr4%2BhSk/xsUrd8FWU/fHGqlfwmhDawCVLZoFnlCBRTpCQe5bvLVFPanHhhu1D3f8sIQFA0XRiD6OiEmcXv0p3M7eGxFa3qoXJx%2BIXDuBRucskyIVfBU%2BVDYPs5ItE3HG3RRM9O0MkDUoh8aHxYaR5grKeu1z9O77%2B/WNjTqgscCc7gTjTDYkK/eVyd%2BB%2Bv2X/61MrNkF/W55M5hVNcOdL8okaWgvAU%3D'

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
