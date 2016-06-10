class AddNumEmailsReceivedToUser < ActiveRecord::Migration
  def change
    add_column :users, :num_emails_received, :integer, default: 0
  end
end
