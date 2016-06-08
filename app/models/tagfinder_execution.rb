require 'open3'

class TagfinderExecution < ActiveRecord::Base
  belongs_to :user
  belongs_to :data_file,   class_name: 'Document'
  belongs_to :params_file, class_name: 'Document'

  validates_presence_of %i(user data_file)

  def status
    case success
      when nil   then 'Still running...'
      when true  then 'Success!'
      when false then 'Failure'
    end
  end

  def run
    puts '------------------------------------------'.black
    puts 'Ignoring params file for now!!'.red
    # doc_url = Document.find(data_file_id).attachment.url
    # # filepath = doc_url
    # filepath = "./tmp/#{Time.now.utc.to_i}-#{File.basename(doc_url)}"

    # stdin, stdout, stderr = Open3.popen3("wget #{doc_url} -O #{filepath};")

    build_result = ''

    # stdout.each_line { |line| print line.green; build_result << line }
    # build_result <<  "\n------------------------------------------\n"
    # stderr.each_line { |line| print line.red;   build_result << line }
    # build_result <<  "\n------------------------------------------\n"

    stdin, stdout, stderr = Open3.popen3("#{executable}")# #{filepath};")
    build_result <<  "\n------------------------------------------\nSTDOUT:\n"
    stdout.each_line { |line| print line.green; build_result << line }
    build_result <<  "\n------------------------------------------\nSTDERR:\n"
    successful = true
    stderr.each_line do |line|
      print line.red
      build_result << line
      successful = false if !line.blank?
    end
    build_result <<  "\n------------------------------------------\n"

    update_attributes(result: build_result, success: successful)
    # stdin, stdout, stderr = Open3.popen3("rm #{filepath};")
    puts '------------------------------------------'.black
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

  private

  def executable
    case Rails.env
      when *%w(development test)   then 'bin/tagfinder-mac'
      when *%w(staging production) then 'bin/tagfinder'
    end
  end
end
