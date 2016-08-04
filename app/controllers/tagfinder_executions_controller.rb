class TagfinderExecutionsController < ApplicationController
  before_action :set_tagfinder_execution, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def show
  end

  def update
    case @tagfinder_execution.success
      when false
        @tagfinder_execution.log("Rerunning execution ##{@tagfinder_execution.id}")
        @tagfinder_execution.log("Resetting # of attempts (was #{@tagfinder_execution.num_attempts})")
        @tagfinder_execution.update_attributes(num_attempts: 0)
        RunExecution.enqueue(@tagfinder_execution.id)
        redirect_to @tagfinder_execution, notice: "Execution ##{@tagfinder_execution.id} is being rerun."
      when true
        redirect_to @tagfinder_execution, alert: "Execution ##{@tagfinder_execution.id} has already succeeded."
      else
        redirect_to @tagfinder_execution, alert: "Execution ##{@tagfinder_execution.id} is already running. We will email you when its results are ready."
    end
  end

  def index
    @user        = current_user
    @data_files  = current_user.documents.select { |doc| doc.upload_file_name.downcase.ends_with? '.mzxml' }
    @param_files = current_user.documents.select { |doc| !doc.upload_file_name.downcase.ends_with? '.mzxml' }
    @tagfinder_executions = TagfinderExecution.where(user: current_user).order(:created_at).decorate.reverse
  end

  def create
    @execution = TagfinderExecution.create(tagfinder_execution_params.merge(user: current_user))
    if @execution.valid?
      RunExecution.enqueue(@execution.id)
      redirect_to tagfinder_executions_path,
        notice: "Tagfinder execution was successfully created. We will email you at #{current_user.email} when the results are ready."
    else
      redirect_to :back, errors: @execution.errors
    end
  end

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
      @tagfinder_execution = TagfinderExecution.find(params[:id]).decorate
      unless current_user == @tagfinder_execution.user || current_user.admin?
        redirect_to root_url, alert: 'You need to sign in for access to this page.'
      end
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
