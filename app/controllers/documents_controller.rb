class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership!, only: %i(destroy)

  def index
    @document  = Document.new
    @documents = current_user.documents
  end

  def create
    @document = current_user.documents.new(document_params)

    if @document.save
      redirect_to documents_path
    else
      puts "> #{@document.errors.full_messages.join("\n")}"
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_path, notice: "The file #{@document.upload_file_name} has been deleted."
  end

  private

  def document_params
    filtered = params.require(:document).permit(:direct_upload_url, :kind)
  end

  def check_ownership!
    unless current_user && current_user.documents.find_by_id(params[:id])
      render_404
    end
  end
end
