class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @cumulative_users     = cumulative_data(User.group_by_week(:created_at))
    @cumulative_documents = cumulative_data(Document.unscoped.group_by_week(:created_at))
  end

  def documents
    @documents = Document.all
  end

  def executions
    @tagfinder_executions = TagfinderExecution.all.decorate
  end

  private

  def cumulative_data(data, order = 'week asc')
    sum = 0
    data.order(order)
      .count.map { |x, y| { x => (sum += y) } }
      .reduce({}, :merge)
  end
end
