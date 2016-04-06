class AdminController < ApplicationController
  before_action :authenticate_admin!

  def metrics
    cumulative_users_sum = 0
    @cumulative_users = User.group_by_week(:created_at)
                            .order("week asc")
                            .count.map { |x,y| { x => (cumulative_users_sum += y)} }
                            .reduce({}, :merge)

    cumulative_documents_sum = 0
    @cumulative_documents = Document.group_by_week(:created_at)
                            .order("week asc")
                            .count.map { |x,y| { x => (cumulative_documents_sum += y)} }
                            .reduce({}, :merge)
  end

  private

  def authenticate_admin!
    render_404 if current_user.nil? || !current_user.admin
  end
end
