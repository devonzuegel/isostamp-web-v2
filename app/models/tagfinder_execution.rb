require 'securerandom'

class TagfinderExecution < ActiveRecord::Base
  belongs_to :user
  belongs_to :data_file,   class_name: 'Document'
  belongs_to :params_file, class_name: 'Document'
  has_many   :results_files
  has_many   :history_outputs
  has_many   :logged_events

  validates_presence_of %i[user data_file]

  include DataAndParamsAttachable

  def run
    return if files_have_been_removed?
    Tagfinder::Runner.call(self, Tagfinder::Connection)
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
end
