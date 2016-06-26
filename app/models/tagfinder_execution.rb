require 'securerandom'

class TagfinderExecution < ActiveRecord::Base
  belongs_to :user
  belongs_to :data_file,   class_name: 'Document'
  belongs_to :params_file, class_name: 'Document'
  has_many   :results_files
  has_many   :logged_events

  before_validation :generate_hex_base
  validates_presence_of %i(user data_file hex_base)

  include DataAndParamsAttachable

  def run
    ActiveRecord::Base.transaction do
      Timeout.timeout(4000) { download_tmp_file }
      successful = shell.run("#{executable} #{tmp_filepath};", logger: true)
      RemoveFile.enqueue(tmp_filepath, run_at: 5.minutes.from_now)
      persist_outputs(successful)
    end
  end

  def shell
    @shell ||= Shell.new
  end

  def successful?
    success == true
  end

  def log(str)
    puts "execution #{id} > #{str}".yellow
    LoggedEvent.create!(
      tagfinder_execution:  self,
      log:                  str
    )
  end


  private


  def generate_hex_base
    self.hex_base ||= SecureRandom.hex
  end

  def tmp_filepath
    "./tmp/#{hex_base}-#{File.basename(data_file_url)}"
  end

  def download_tmp_file
    if !File.file?(tmp_filepath)
      log("Downloading #{tmp_filepath} from s3...")
      shell.run("wget #{data_file_url} -O #{tmp_filepath};", logger: true)  # Download file from s3
      log("Done downloading #{tmp_filepath} from s3")
    else
      log("NOT downloading #{tmp_filepath} from s3 because its already there...")
    end

  end

  def persist_outputs(successful)
    update_attributes(
      stdouts:  JSON.pretty_generate(shell.stdouts.as_json),
      stderrs:  JSON.pretty_generate(shell.stderrs.as_json),
      success:  successful
    )
  end

  def executable
    Rails.env.production? ? 'bin/tagfinder' : 'bin/tagfinder-mac'
  end
end
