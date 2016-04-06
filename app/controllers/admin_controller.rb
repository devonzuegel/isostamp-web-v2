class AdminController < ApplicationController
  before_action :authenticate_admin!

  def metrics
  end

  private

  def authenticate_admin!
    render_404 if current_user.nil? || !current_user.admin
  end
end
