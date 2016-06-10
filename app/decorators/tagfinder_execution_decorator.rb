class TagfinderExecutionDecorator < Draper::Decorator
  delegate_all

  def status
    case success
      when nil   then 'Still running...'
      when true  then 'Success!'
      when false then 'Failure'
    end
  end

  def data_file_removed?
    data_file.nil? && !data_file_id.nil?
  end

  def data_file_url
    data_file.direct_upload_url
  end

  def data_file_name
    data_file.upload_file_name
  end

  def used_default_params?
    params_file_id.nil?
  end

  def params_file_removed?
    !used_default_params? && params_file.nil?
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
