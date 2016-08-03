RSpec.describe Tagfinder::Connection, type: :model do
  let(:request)   { instance_double(Tagfinder::Request, to_s: 'dummy url', params: {}) }
  let(:response)  { 'hi' }
  let(:fake_http) { class_double(HTTP, get: instance_double(HTTP::Response, body: response)) }

  before { stub_const('HTTP', fake_http) }

  it 'makes a request to the given url' do
    described_class.call(request)
    expect(fake_http).to have_received(:get).with(request.to_s, params: request.params)
  end

  it 'retrieves the body of the response' do
    expect(described_class.call(request)).to eql response
  end
end
