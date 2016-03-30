class DataController < ApplicationController
  before_action :authenticate_user!

  def index
    @data = DataUpload.where(user: current_user) + [{ name: 'testfile.mzXML', format: 'mzXML' }]
  end

  def new
  end

  def create
  end

  def destroy
  end
end
