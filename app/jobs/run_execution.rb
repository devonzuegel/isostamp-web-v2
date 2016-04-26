require 'open3'

class RunExecution < Que::Job
  def run(data_file_id, params_file_id = nil)
    puts "\n\ndata_file_id = #{data_file_id}\nparams_file_id = #{params_file_id}\n\n"

    puts '------------------------------------------'.black
    puts 'Ignoring params file for now!!'.red
    doc_url = Document.find(data_file_id).attachment.url
    filepath = "./tmp/#{Time.now.utc.to_i}-#{File.basename(doc_url)}"

    stdin, stdout, stderr = Open3.popen3("wget #{doc_url} -O #{filepath};")
    stdout.each_line { |line| print line.green }
    stderr.each_line { |line| print line.red }

    executable = Rails.env.development? ? 'bin/tagfinder-mac' : 'bin/tagfinder'
    stdin, stdout, stderr = Open3.popen3("#{executable} #{filepath};")
    stdout.each_line { |line| print line.green }
    stderr.each_line { |line| print line.red }

    stdin, stdout, stderr = Open3.popen3("rm #{filepath};")
    puts '------------------------------------------'.black
    destroy

    # ActiveRecord::Base.transaction do
    # end
  end
end