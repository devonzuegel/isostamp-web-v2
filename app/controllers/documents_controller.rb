class DocumentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @documents = Document.all
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.name = @document.attachment.filename

    if @document.save
      redirect_to documents_path, notice: "The file #{@document.name} has been uploaded."
    else
      render 'new'
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_path, notice: "The file #{@document.name} has been deleted."
  end

  private

  def document_params
    params.require(:document).permit(:attachment)
  end
end
