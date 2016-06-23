require 'action_controller/test_case'

class TagfinderResultMailer < ApplicationMailer
  include ActionView::Helpers::UrlHelper
  add_template_helper(ApplicationHelper)

  default from: ENV['EMAIL_SENDER']

  def sample_email(tagfinder_execution, preview: false)
    @tagfinder_execution = tagfinder_execution.decorate
    @link = link_to('Details', with_host_prefix(@tagfinder_execution.url))

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
      to:         'devonzuegel@gmail.com', # user.email, # TODO change me
      subject:    subject,
      html:       html_template
    }
  end

  def log_sending
    puts "> Sending email to #{user.email}...".blue
    user.increment!(:num_emails_received)
    @tagfinder_execution.update_attributes!(email_sent: Time.now)
  end

  def subject
    time_str  = Time.now.strftime("%h %d %H:%M:%S")
    result = @tagfinder_execution.successful? ? 'succeeded!' : 'failed'
    base = "Isostamp results: #{data_file.upload_file_name} #{result} (#{time_str})"
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

  def with_host_prefix(url)
    URI.join(root_url, url).to_s
  end
end