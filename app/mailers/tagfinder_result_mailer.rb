class TagfinderResultMailer < ApplicationMailer
  default from: ENV['EMAIL_SENDER']

  def sample_email(tagfinder_execution)
    @tagfinder_execution = tagfinder_execution

    message_params = {
      from:       ENV['EMAIL_SENDER'],
      to:         @tagfinder_execution.user.email,
      subject:    "Isostamp results: #{@tagfinder_execution.data_file.upload_file_name} (#{Time.now.strftime("%h %d %H:%M:%S")})",
      html:        render_to_string(template: "../views/tagfinder_result_mailer/sample_email").to_str
    }

    puts "> Sending email to #{@tagfinder_execution.user.email}...".blue
    @tagfinder_execution.user.increment!(:num_emails_received)
    # mail(message_params)

    mg_client = Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
    mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params
  end
end