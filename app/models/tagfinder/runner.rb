module Tagfinder
  class Runner
    include Concord.new(:tagfinder_execution)
  end
end

# http://ec2-54-249-88-210.ap-northeast-1.compute.amazonaws.com/tagfinder
#     ?
#     key=newpassword&
#     data_url=https://regis-web.systemsbiology.net/rawfiles/lcq/7MIX_STD_110802_1.mzXML
#     params_url=https://regis-web.systemsbiology.net/rawfiles/lcq/7MIX_STD_110802_1.mzXML
