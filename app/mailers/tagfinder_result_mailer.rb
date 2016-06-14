class TagfinderResultMailer < ApplicationMailer
  default from: ENV['EMAIL_SENDER']

  def sample_email(tagfinder_execution, preview: false)
    @tagfinder_execution = tagfinder_execution

    if preview
      mail(message_params)
    else
      mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params
      log_sending
    end
  end

  private

  def message_params
    {
      from:       ENV['EMAIL_SENDER'],
      to:         user.email,
      subject:    subject,
      html:       html_template
    }
  end

  def log_sending
    puts "> Sending email to #{user.email}...".blue
    user.increment!(:num_emails_received)
    @tagfinder_execution.update_attributes(email_sent: Time.now)
  end

  def subject
    time_str  = Time.now.strftime("%h %d %H:%M:%S")
    base = "Isostamp results: #{data_file.upload_file_name} (#{time_str})"
    ENV['ENV'] == 'production' ?  base : "[#{ENV['ENV'].upcase}] #{base}"
  end

  def mg_client
    @mg_client ||= Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
  end

  def data_file
    @tagfinder_execution.data_file
  end

  def html_template
    render_to_string(template: "../views/tagfinder_result_mailer/sample_email").to_str
  end

  def user
    @tagfinder_execution.user
  end
end