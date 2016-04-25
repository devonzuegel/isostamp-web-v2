class TagfinderExecutionsController < ApplicationController
  before_action :set_tagfinder_execution, only: [:show, :edit, :update, :destroy]

  # GET /tagfinder_executions
  # GET /tagfinder_executions.json
  def index
    @tagfinder_executions = TagfinderExecution.all
  end

  # GET /tagfinder_executions/1
  # GET /tagfinder_executions/1.json
  def show
  end

  # GET /tagfinder_executions/new
  def new
    @tagfinder_execution = TagfinderExecution.new
  end

  # GET /tagfinder_executions/1/edit
  def edit
  end

  # POST /tagfinder_executions
  # POST /tagfinder_executions.json
  def create
    @tagfinder_execution = TagfinderExecution.new(tagfinder_execution_params)

    respond_to do |format|
      if @tagfinder_execution.save
        format.html { redirect_to @tagfinder_execution, notice: 'Tagfinder execution was successfully created.' }
        format.json { render :show, status: :created, location: @tagfinder_execution }
      else
        format.html { render :new }
        format.json { render json: @tagfinder_execution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tagfinder_executions/1
  # PATCH/PUT /tagfinder_executions/1.json
  def update
    respond_to do |format|
      if @tagfinder_execution.update(tagfinder_execution_params)
        format.html { redirect_to @tagfinder_execution, notice: 'Tagfinder execution was successfully updated.' }
        format.json { render :show, status: :ok, location: @tagfinder_execution }
      else
        format.html { render :edit }
        format.json { render json: @tagfinder_execution.errors, status: :unprocessable_entity }
      end
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
      params.require(:tagfinder_execution).permit(:user_id, :data_file_id, :params_file_id, :email_sent, :success)
    end
end
