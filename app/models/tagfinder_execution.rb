class TagfinderExecution < ActiveRecord::Base
  belongs_to :user
  belongs_to :data_file,   class_name: 'Document'
  belongs_to :params_file, class_name: 'Document'

  validates_presence_of %i(user data_file)

  include DataAndParamsAttachable

  def run
    successful = shell.run("#{executable} #{tmp_filepath};")
    persist_results(successful)
    remove_tmp_file

    puts "tmp_filepath = '#{tmp_filepath}'".green
    puts "tmp directory:".green
    stdin, stdout, stderr = Open3.popen3("ls ./tmp;")
    stdout.each_line { |line| print line.white.on_black }
    stderr.each_line { |line| print line.red.on_black }
  end

  def results_files
    basefilename = data_file_name(with_extension: false)
    [
      "#{basefilename}_chart.txt",
      "#{basefilename}_filter_log.txt",
      "#{basefilename}_filter_log2.txt",
      "#{basefilename}_filtered.mzxml",
      "#{basefilename}_massspec.csv",
      "#{basefilename}_summary.txt",
    ]
  end

  private

  def shell
    @shell ||= Shell.new
  end

  def tmp_filepath
    if @tmp_filepath.nil?
      @tmp_filepath = "./tmp/#{SecureRandom.hex}-#{File.basename(data_file_url)}"
      download_tmp_file
    end
    @tmp_filepath
  end

  def download_tmp_file
    shell.run("wget #{data_file_url} -O #{@tmp_filepath};")
  end

  def remove_tmp_file
    puts "Removing tmp file '#{@tmp_filepath}'...".blue
    stdin, stdout, stderr = Open3.popen3("rm #{@tmp_filepath};")
  end

  def persist_results(successful)
    update_attributes(
      stdouts:  JSON.pretty_generate(shell.stdouts.as_json),
      stderrs:  JSON.pretty_generate(shell.stderrs.as_json),
      success:  successful
    )
  end

  def executable
    case Rails.env
      when *%w(development test)   then 'bin/tagfinder-mac'
      when *%w(staging production) then 'bin/tagfinder'
    end
  end
end
