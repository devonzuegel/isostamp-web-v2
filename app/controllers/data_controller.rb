class DataController < ApplicationController
  before_action :authenticate_user!

  def index
    @data = DataUpload.all
    # @data = DataUpload.where(user: current_user) + [{ name: 'testfile.mzXML', format: 'mzXML' }]
  end

  def new
    @data_upload = DataUpload.new
  end

  def create
    @data_upload = DataUpload.new(data_upload_params)
    @data_upload.name = @data_upload.attachment.filename

    if @data_upload.save
      redirect_to data_path, notice: "The file #{@data_upload.name} has been uploaded."
    else
      render 'new'
    end
  end

  def destroy
    @data_upload = DataUpload.find(params[:id])
    @data_upload.destroy
    redirect_to data_path, notice: "The file #{@data_upload.name} has been deleted."
  end

  private

  def data_upload_params
    params.require(:data_upload).permit(:attachment)
  end
end
