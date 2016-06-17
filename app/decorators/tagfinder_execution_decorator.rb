class TagfinderExecutionDecorator < Draper::Decorator
  delegate_all

  def created_at
    h.formatted_time_ago(object.created_at)
  end

  def metadata
    [{
      label:   'Created at',
      value:   created_at
    }, {
      label:   'Owner',
      value:   h.link_to(user.name, h.user_path(user))
    }, {
      label:   'Email sent',
      value:   email_sent_info
    }, {
      label:   'Status',
      value:   status
    }]
  end

  def data_file_info
    if data_file.nil?
      h.disabled 'File has been removed'
    else
      h.link_to data_file.upload_file_name, data_file.direct_upload_url
    end
  end

  def params_file_info
    if used_default_params?
      h.disabled 'Used default configuration'
    elsif params_file_removed?
      h.disabled 'File has been removed'
    else
      h.link_to params_file.upload_file_name, params_file.direct_upload_url
    end
  end

  def email_sent_info
    if email_sent.nil?
      h.disabled 'Email not yet sent'
    else
      h.formatted_time_ago(email_sent)
    end
  end

  def status
    case success
      when nil   then h.content_tag(:div, 'Still running...', :class => 'label label-info')
      when true  then h.content_tag(:div, 'Success!',         :class => 'label label-success')
      when false then h.content_tag(:div, 'Failure',          :class => 'label label-danger')
    end
  end

  def results_files
    object.results_files.map do |file|
      inner = [
        h.disabled(file.filename),
        h.content_tag(:div, 'Processing...', :class => 'label label-info margin-left')
      ].join.html_safe
      if file.direct_upload_url.nil?
        h.content_tag :div, inner
      else
        h.link_to  file.filename, file.direct_upload_url
      end
    end
  end

  def stdouts_list
    JSON.parse(stdouts).select(&:present?)
  end

  def stderrs_list
    JSON.parse(stderrs).select(&:present?)
  end
end
