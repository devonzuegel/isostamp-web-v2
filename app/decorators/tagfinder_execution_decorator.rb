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
      label:   'Status',
      value:   status
    }, {
      label:   'Owner',
      value:   h.link_to(user.name, h.user_path(user))
    }, {
      label:   'Email sent',
      value:   email_sent_info
    }]
  end

  def data_file_info
    if data_file.nil?
      h.disabled 'File has been removed'
    else
      h.link_to data_file.direct_upload_url do
        h.content_tag(:i, '', :class => 'fa fa-file-text right-spacer') +
        data_file.upload_file_name
      end
    end
  end

  def params_file_info
    if used_default_params?
      h.disabled 'Used default configuration'
    elsif params_file_removed?
      h.disabled 'File has been removed'
    else
      h.link_to params_file.direct_upload_url do
        h.content_tag(:i, '', :class => 'fa fa-file-text right-spacer') +
        params_file.upload_file_name
      end
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
      if file.direct_upload_url.nil?
        h.content_tag :div, [
          h.disabled(h.content_tag(:i, '', :class => 'fa fa-file-text right-spacer')),
          h.disabled(file.filename),
          h.content_tag(:div, 'Processing...', :class => 'label label-info margin-left')
        ].join.html_safe
      else
        h.document_link(file.direct_upload_url, file.filename)
      end
    end
  end

  def stdouts_list
    JSON.parse(stdouts).select(&:present?)
  end

  def stderrs_list
    JSON.parse(stderrs).select(&:present?)
  end

  def url
    h.url_for(object)
  end
end
