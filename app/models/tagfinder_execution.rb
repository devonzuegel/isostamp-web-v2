class TagfinderExecution < ActiveRecord::Base
  belongs_to :user
  belongs_to :data_file,   class_name: 'Document'
  belongs_to :params_file, class_name: 'Document'

  validates_presence_of %i(user data_file)

  def run
    puts '=========================================='.black
    puts '=========================================='.black
    @build_result = ''
    successful = shell.run("#{executable} #{tmp_filepath};")
    puts "tmp_filepath = '#{tmp_filepath}'".green
    puts "tmp directory:".green
    stdin, stdout, stderr = Open3.popen3("ls ./tmp;")
    stdout.each_line { |line| print line.white.on_black }
    stderr.each_line { |line| print line.red.on_black }
    persist_results(successful)
    remove_tmp_file
    puts '=========================================='.black
    puts '=========================================='.black
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

  def status
    case success
      when nil   then 'Still running...'
      when true  then 'Success!'
      when false then 'Failure'
    end
  end

  private

  def shell
    @shell ||= Shell.new
  end

  def tmp_filepath
    if @tmp_filepath.nil?
      @tmp_filepath = "./tmp/#{Time.now.utc.to_i}-#{File.basename(data_file_url)}"
      download_tmp_file
    end

    @tmp_filepath
  end

  def download_tmp_file
    stdin, stdout, stderr = Open3.popen3("wget #{data_file_url} -O #{@tmp_filepath};")

    @build_result << "\nDownloading to '#{@tmp_filepath}':\n"
    stdout.each_line { |line| @build_result << line }
    @build_result <<  "\n\n"
    stderr.each_line { |line| @build_result << line }
    @build_result <<  "\n\n"
  end

  def print_contents_of_file
    stdin, stdout, stderr = Open3.popen3("cat #{@tmp_filepath};")

    @build_result << "\nCONTENTS OF '#{@tmp_filepath}':\n"
    stdout.each_line { |line| print line.green; @build_result << line }
    @build_result <<  "\n\n"
    stderr.each_line { |line| print line.red;   @build_result << line }
    @build_result <<  "\n\n"
  end

  def remove_tmp_file
    puts "Removing tmp file '#{@tmp_filepath}'...".blue
    stdin, stdout, stderr = Open3.popen3("rm #{@tmp_filepath};")
  end

  def persist_results(successful)
    update_attributes(result: @built_result, success: successful)
    puts 'ATTRIBUTES PERSISTED'.black
    puts '=========================================='.black
  end

  def executable
    case Rails.env
      when *%w(development test)   then 'bin/tagfinder-mac'
      when *%w(staging production) then 'bin/tagfinder'
    end
  end
end
