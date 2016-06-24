class LoggedEvent < ActiveRecord::Base
  belongs_to :tagfinder_execution
  validates_presence_of :tagfinder_execution
end
