json.array!(@tagfinder_executions) do |tagfinder_execution|
  json.extract! tagfinder_execution, :id, :user_id, :data_file_id, :params_file_id, :email_sent, :success
  json.url tagfinder_execution_url(tagfinder_execution, format: :json)
end
