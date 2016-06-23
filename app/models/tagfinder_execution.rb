require 'securerandom'

class TagfinderExecution < ActiveRecord::Base
  belongs_to :user
  belongs_to :data_file,   class_name: 'Document'
  belongs_to :params_file, class_name: 'Document'
  has_many   :results_files

  before_validation :generate_hex_base
  validates_presence_of %i(user data_file hex_base)

  include DataAndParamsAttachable

  def run
    successful = shell.run("#{executable} #{tmp_filepath};", logger: true)
    # remove_tmp_file(tmp_filepath) # TODO
    persist_outputs(successful)
  end

  def successful?
    success == true
  end

  def shell
    @shell ||= Shell.new
  end

  private

  def generate_hex_base
    self.hex_base ||= SecureRandom.hex
  end

  def tmp_filepath
    if @tmp_filepath.nil?
      @tmp_filepath = "./tmp/#{hex_base}-#{File.basename(data_file_url)}"
      shell.run("wget #{data_file_url} -O #{tmp_filepath};", logger: true)  # Download file from s3
    else
      puts "@tmp_filepath is not nil!!!! => '#{@tmp_filepath}'".red
    end
    @tmp_filepath
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
