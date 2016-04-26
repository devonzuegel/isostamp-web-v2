require 'open3'

class AdminController < ApplicationController
  before_action :authenticate_admin!

  def metrics
    @cumulative_users     = cumulative_data(User.group_by_week(:created_at))
    @cumulative_documents = cumulative_data(Document.group_by_week(:created_at))
  end

  def documents
    # puts '------------------------------------------'
    # doc_url = Document.first.attachment.url
    # filepath = "./tmp/#{Time.now.utc.to_i}-#{File.basename(doc_url)}"

    # stdin, stdout, stderr = Open3.popen3("wget #{doc_url} -O #{filepath};")
    # stdout.each_line { |line| puts line.green }
    # stderr.each_line { |line| puts line.red }


    # executable = Rails.env.development? ? 'bin/tagfinder-mac' : 'bin/tagfinder'
    # stdin, stdout, stderr = Open3.popen3("#{executable} #{filepath};")
    # stdout.each_line { |line| puts line.green }
    # stderr.each_line { |line| puts line.red }

    # stdin, stdout, stderr = Open3.popen3("rm #{filepath};")
    # puts '------------------------------------------'
    @documents = Document.all
  end

  private

  def cumulative_data(data, order = 'week asc')
    sum = 0
    data.order(order)
        .count.map { |x,y| { x => (sum += y)} }
        .reduce({}, :merge)
  end
end
