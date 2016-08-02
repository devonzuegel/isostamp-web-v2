require 'securerandom'

class TagfinderExecution < ActiveRecord::Base
  belongs_to :user
  belongs_to :data_file,   class_name: 'Document'
  belongs_to :params_file, class_name: 'Document'
  has_many   :results_files
  has_many   :history_outputs
  has_many   :logged_events

  before_validation :generate_hex_base
  validates_presence_of %i[user data_file hex_base]

  include DataAndParamsAttachable

  def run
    return if files_have_been_removed?
    ActiveRecord::Base.transaction do
      download_tmp_files
      log("Running command: `#{command}`")
      result = shell.run(command, logger: true)
      remove_tmp_files
      persist_outputs(result)
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
    LoggedEvent.create!(tagfinder_execution: self, log: str)
  end

  private

  def generate_hex_base
    self.hex_base ||= SecureRandom.hex
  end

  def persist_outputs(successful)
    update_attributes(
      stdouts: JSON.pretty_generate(shell.stdouts.as_json),
      stderrs: JSON.pretty_generate(shell.stderrs.as_json),
      success: successful
    )
  end

  def download_tmp_files
    download_tmp_file(tmp_data_filepath, data_file_url)
    return if used_default_params?
    download_tmp_file(tmp_params_filepath, params_file_url)
  end

  def download_tmp_file(tmp_filepath, file_url)
    if !File.file?(tmp_filepath)
      log("Downloading #{tmp_filepath} from s3...\n\n")
      shell.run("wget #{file_url} -O #{tmp_filepath};", logger: true)
      log("Done downloading #{tmp_filepath} from s3\n\n")
    else
      log("NOT downloading #{tmp_filepath} from s3 because its already there...")
    end
  end

  def remove_tmp_files
    RemoveFile.enqueue(tmp_data_filepath, run_at: 5.minutes.from_now)
    return if used_default_params?
    RemoveFile.enqueue(tmp_params_filepath, run_at: 5.minutes.from_now)
  end

  def command
    if used_default_params?
      "#{executable} #{tmp_data_filepath};"
    else
      "#{executable} #{tmp_data_filepath} #{tmp_params_filepath};"
    end
  end

  def executable
    Rails.env.production? ? 'bin/tagfinder' : 'bin/tagfinder-mac'
  end
end
