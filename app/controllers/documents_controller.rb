class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership!, only: %i(destroy)

  def index
    @document  = Document.new

    @documents = current_user.documents
  end

  # @http_method XHR POST
  # @url /documents
  def create
    ap params
    @document = current_user.documents.new(document_params)
    # ap params
    # @document = Document.new(document_params)

    if @document.save
      # redirect_to documents_path, notice:
      puts "The file #{@document} is being uploaded. We will send you an email when your upload is complete.".red
    else
      # flash[:error] =
      puts @document.errors.full_messages.join("\n").red
      # redirect_to documents_path
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_path, notice: "The file #{@document} has been deleted."
  end

  private

  def document_params
    filtered = params.require(:document).permit(:direct_upload_url)
  end

  def check_ownership!
    unless current_user && current_user.documents.find_by_id(params[:id])
      render_404
    end
  end
end
