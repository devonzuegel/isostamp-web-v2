class TagfinderExecution < ActiveRecord::Base
  belongs_to :user
  belongs_to :data_file,   class_name: 'Document'
  belongs_to :params_file, class_name: 'Document'

  validates_presence_of %i(user data_file)

  def run
    puts '=========================================='.black
    puts '=========================================='.black
    # successful = shell.run("#{executable} #{tmp_filepath};")
    successful = shell.run("echo hello;")
    persist_results(successful)
    remove_tmp_file
    puts '=========================================='.black
    puts '=========================================='.black
  end
    # puts "tmp_filepath = '#{tmp_filepath}'".green
    # puts "tmp directory:".green
    # stdin, stdout, stderr = Open3.popen3("ls ./tmp;")
    # stdout.each_line { |line| print line.white.on_black }
    # stderr.each_line { |line| print line.red.on_black }

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
    shell.run("wget #{data_file_url} -O #{@tmp_filepath};")
  end

  def print_contents_of_file
    shell.run("cat #{@tmp_filepath};")
  end

  def remove_tmp_file
    puts "Removing tmp file '#{@tmp_filepath}'...".blue
    stdin, stdout, stderr = Open3.popen3("rm #{@tmp_filepath};")
  end

  def persist_results(successful)
    result  = "OUTPUTS = #{JSON.pretty_generate(shell.output.as_json)}"
    result += "\n\n-------------------------------------------------\n\n"
    result += "ERRORS  = #{JSON.pretty_generate(shell.errors.as_json)}"
    update_attributes(result: result, success: successful)
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
