class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership!, only: %i(destroy)

  def index
    @document = Document.new
    @documents = Document.where(user: current_user)
  end

  def create
    @document = Document.new(document_params)
    @document.update_attributes(name: @document.attachment.filename, user: current_user)

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
    params.require(:document).permit(:attachment, :name)
  end

  def check_ownership!
    unless current_user && current_user.documents.find_by_id(params[:id])
      render_404
    end
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404
  end
end
