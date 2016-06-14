class TagfinderExecution < ActiveRecord::Base
  belongs_to :user
  belongs_to :data_file,   class_name: 'Document'
  belongs_to :params_file, class_name: 'Document'

  validates_presence_of %i(user data_file)

  include DataAndParamsAttachable

  def run
    successful = shell.run("#{executable} #{tmp_filepath};")
    persist_outputs(successful)
    remove_tmp_file

    if successful
      UploadResultsFilesToS3.enqueue(hex_base, id)
    end
  end

  private

  def shell
    @shell ||= Shell.new
  end

  def tmp_filepath
    if @tmp_filepath.nil?
      @tmp_filepath = "./tmp/#{hex_base}#{File.basename(data_file_url)}"
      shell.run("wget #{data_file_url} -O #{tmp_filepath};")  # Download file from s3
    end
    @tmp_filepath
  end

  def hex_base
    @hex_base ||= "#{SecureRandom.hex}-"
  end

  def remove_tmp_file
    puts "Removing tmp file '#{tmp_filepath}'...".blue
    stdin, stdout, stderr = Open3.popen3("rm #{tmp_filepath};")
  end

  def persist_outputs(successful)
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
