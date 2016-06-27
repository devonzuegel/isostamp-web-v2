class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!,         except: %i(show update)
  before_action :authenticate_user_or_admin!, only:   %i(update)

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "#{@user.name} has been removed."
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to tagfinder_executions_path, notice: "Your email has been updated!"
    else
      redirect_to tagfinder_executions_path, alert: @user.errors.full_messages.join("\n")
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
