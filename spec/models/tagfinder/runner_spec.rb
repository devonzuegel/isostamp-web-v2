require 'rails_helper'

RSpec.describe Tagfinder::Runner, type: :model do
  context 'data file only' do
    let(:execution)  { build(:tagfinder_execution) }
    let(:connection) { double(Tagfinder::Connection) }
    let(:response) do
      File.read(Pathname.new('spec').join('fixtures', 'tagfinder-api-response.json'))
    end
    before { allow(connection).to receive(:call).and_return(response) }

    it 'makes request to tagfinder API' do
      described_class.call(execution, connection)
      expect(connection).to have_received(:call)
    end

    it 'creates results files from returned results urls' do
      results_files = described_class.call(execution, connection).results_files
      expect(results_files.map(&:direct_upload_url))
        .to eql JSON.parse(response).fetch('results_urls')
    end

    it 'logs the output'
    # Create (or change existing) class that holds content of history hash from response
  end

  context 'data & params files' do
    it '...'
  end
end
