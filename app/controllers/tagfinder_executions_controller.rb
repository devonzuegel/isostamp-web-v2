class TagfinderExecutionsController < ApplicationController
  before_action :set_tagfinder_execution, only: [:show, :edit, :update, :destroy]

  # GET /tagfinder_executions
  # GET /tagfinder_executions.json
  def index
    @data_files     = current_user.documents
    @param_files    = current_user.documents
    @default_params = [[ nil, 'Use Default Configuration' ]]

    @tagfinder_executions = TagfinderExecution.where(user: current_user).reverse
  end

  # POST /tagfinder_executions
  # POST /tagfinder_executions.json
  def create
    @tagfinder_execution = TagfinderExecution.new(tagfinder_execution_params.merge(user:current_user))
    RunExecution.enqueue(tagfinder_execution_params.fetch('data_file_id'), tagfinder_execution_params['params_file_id'])
    if @tagfinder_execution.save
      redirect_to tagfinder_executions_path, notice: 'Tagfinder execution was successfully created.'
    else
      render :new
    end
  end

  # DELETE /tagfinder_executions/1
  # DELETE /tagfinder_executions/1.json
  def destroy
    @tagfinder_execution.destroy
    respond_to do |format|
      format.html { redirect_to tagfinder_executions_url, notice: 'Tagfinder execution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tagfinder_execution
      @tagfinder_execution = TagfinderExecution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tagfinder_execution_params
      filtered = params.require(:tagfinder_execution).permit(:user_id, :data_file_id, :params_file_id, :email_sent, :success)

      filtered['data_file_id'] = filtered['data_file_id'].to_i

      if filtered['params_file_id'] == 'on'
        filtered.delete('params_file_id')
      else
        filtered['params_file_id'] = filtered['params_file_id'].to_i
      end

      filtered
    end
end
