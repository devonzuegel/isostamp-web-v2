class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :correct_user?, only: %i(show)
  before_action :authenticate_admin!, except: %i(show)

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "#{@user.name} has been removed."
  end

end
