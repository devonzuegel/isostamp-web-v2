module Tagfinder
  class Runner
    URL = ENV['EC2_URL']
    KEY = ENV['EC2_KEY']

    include Procto.call, Concord.new(:execution, :connection)

    private_class_method :new

    def call
      response = JSON.parse(connection.call(Request.new(URL, execution_params)))
      ap response
      log_output(response)
      log_results(response)
      execution
    end

    private

    def log_results(response)
      return unless successful?(response)
      response.fetch('results_urls').each do |url|
        ResultsFile.create!(
          filename:            File.basename(url),
          direct_upload_url:   url,
          tagfinder_execution: execution
        )
      end
    end

    def log_output(response)
      logged = { tagfinder_execution: execution }
      execution.update_attributes(success: successful?(response))
      puts 'execution: ----------------------------------------'.gray
      ap execution

      if successful?(response)
        response.fetch('history').each { |h| ap h; HistoryOutput.create!(logged.merge(h)) }
      else
        execution.log(response['error'])
      end
    end

    def successful?(response)
      return false if response['history'].nil?
      response['history'].map { |output| output['status'] }.reduce(&:|) == 0
    end

    def execution_params
      default_params =
        {
          data_url: execution.data_file.direct_upload_url,
          key:      KEY
        }

      return default_params if execution.used_default_params?

      default_params.merge(params_url: execution.params_file.direct_upload_url)
    end
  end
end

# http://ec2-54-249-88-210.ap-northeast-1.compute.amazonaws.com/tagfinder
#     ?
#     key=newpassword&
#     data_url=https://regis-web.systemsbiology.net/rawfiles/lcq/7MIX_STD_110802_1.mzXML
#     params_url=https://regis-web.systemsbiology.net/rawfiles/lcq/7MIX_STD_110802_1.mzXML
