class TagfinderResultMailer < ApplicationMailer
  default from: ENV['EMAIL_SENDER']

  def sample_email(tagfinder_execution, preview: false)
    @tagfinder_execution = tagfinder_execution

    if preview
      mail(message_params)
    else
      puts "> Sending email to #{@tagfinder_execution.user.email}...".blue
      @tagfinder_execution.user.increment!(:num_emails_received)

      mg_client = Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
      mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params
    end
  end

  private

  def message_params
    data_file = @tagfinder_execution.data_file
    time_str  = Time.now.strftime("%h %d %H:%M:%S")

    {
      from:       ENV['EMAIL_SENDER'],
      to:         @tagfinder_execution.user.email,
      subject:    "Isostamp results: #{data_file.upload_file_name} (#{time_str})",
      html:        render_to_string(template: "../views/tagfinder_result_mailer/sample_email").to_str
    }
  end
end