class TagfinderExecutionDecorator < Draper::Decorator
  delegate_all

  def status
    case success
      when nil   then 'Still running...'
      when true  then 'Success!'
      when false then 'Failure'
    end
  end

  def results_files
    basefilename = data_file_name(with_extension: false)
    [
      "#{basefilename}_chart.txt",
      "#{basefilename}_filter_log.txt",
      "#{basefilename}_filter_log2.txt",
      "#{basefilename}_filtered.mzxml",
      "#{basefilename}_massspec.csv",
      "#{basefilename}_summary.txt",
    ]
  end

  def data_file_removed?
    object.data_file.nil? && !data_file_id.nil?
  end

  def data_file_url
    object.data_file.direct_upload_url
  end

  def data_file_name(with_extension: true)
    filename = object.data_file.upload_file_name
    if with_extension
      filename
    else
      File.basename(filename,File.extname(filename))
    end
  end

  def used_default_params?
    params_file_id.nil?
  end

  def params_file_removed?
    !used_default_params? && params_file.nil?
  end

  def data_file
    if object.data_file.nil?
      h.content_tag :i, :class => 'grey' do
        'File has been removed'
      end
    else
      h.content_tag :a, href: object.data_file.direct_upload_url do
        object.data_file.upload_file_name
      end
    end
  end

  def params_file
    if used_default_params?
      h.content_tag :i, :class => 'grey' do
        'Used default configuration'
      end
    elsif params_file_removed?
      h.content_tag :i, :class => 'grey' do
        'File has been removed'
      end
    else
      h.content_tag :a, href: params_file.direct_upload_url do
        params_file.upload_file_name
      end
    end
  end

  def created_at
    "#{h.time_ago_in_words(object.created_at)} ago".capitalize
  end
end
