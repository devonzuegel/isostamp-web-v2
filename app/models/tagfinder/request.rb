module Tagfinder
  class Request
    extend Forwardable
    include Concord.new(:url, :params)

    attr_reader :params
    def_delegator :url, :to_s

    def initialize(raw_url, params = nil)
      super(validated_url(raw_url), params || {})
    end

    private

    def validated_url(url)
      uri = URI.parse(url)
      fail URI::InvalidURIError unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      uri
    end
  end
end
