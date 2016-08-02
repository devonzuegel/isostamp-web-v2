RSpec.describe Tagfinder::Request do
  let(:valid_http)  { 'http://example.com' }
  let(:valid_https) { 'https://example.com' }
  let(:bad_uri)     { 'dummy url' }
  let(:bad_str)     { 'laskdfj' }

  context 'basic request without params' do
    it 'initializes a request from a valid http url' do
      expect(described_class.new(valid_http).to_s).to eql valid_http
    end

    it 'initializes a request from a valid https url' do
      expect(described_class.new(valid_https).to_s).to eql valid_https
    end

    it 'fails when given a non-uri' do
      expect { described_class.new(bad_uri) }.to raise_error URI::InvalidURIError
    end

    it 'fails when given a string without spaces' do
      expect { described_class.new(bad_str) }.to raise_error URI::InvalidURIError
    end

    it 'has no parameters' do
      expect(described_class.new(valid_http).params).to eql({})
    end
  end

  context 'request with params' do
    let(:params)               { { param1: 'blah' } }
    let(:instance_with_params) { described_class.new(valid_https, params) }

    it 'has the expected params' do
      expect(instance_with_params.params).to eql(params)
    end
  end
end
