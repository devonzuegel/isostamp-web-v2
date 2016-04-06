class AdminController < ApplicationController
  before_action :authenticate_admin!

  def metrics
    @cumulative_users     = cumulative_data(User.group_by_week(:created_at))
    @cumulative_documents = cumulative_data(Document.group_by_week(:created_at))
  end

  private

  def authenticate_admin!
    render_404 if current_user.nil? || !current_user.admin
  end

  def cumulative_data(data, order = 'week asc')
    sum = 0
    data.order(order)
        .count.map { |x,y| { x => (sum += y)} }
        .reduce({}, :merge)
  end
end
