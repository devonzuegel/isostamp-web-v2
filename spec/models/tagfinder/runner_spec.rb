require 'rails_helper'

RSpec.describe Tagfinder::Runner, type: :model do
  let(:connection) { double(Tagfinder::Connection) }
  let(:response) { File.read(Pathname.new('spec').join('fixtures', 'tagfinder-api-response.json')) }
  before { allow(connection).to receive(:call).and_return(response) }

  context 'data file only' do
    let(:execution) { build(:tagfinder_execution) }

    it 'makes request to tagfinder API' do
      described_class.call(execution, connection)
      expect(connection).to have_received(:call)
    end

    it 'creates results files from returned results urls' do
      results_files = described_class.call(execution, connection).results_files
      expect(results_files.map(&:direct_upload_url))
        .to eql JSON.parse(response).fetch('results_urls')
    end

    it 'logs the output' do
      history = described_class.call(execution, connection).history_outputs.map(&:attributes)
      filtered_keys_history =
        history.map do |o|
          o.slice(*%w[command stderr stdout status]).deep_stringify_keys
        end
      expect(filtered_keys_history).to eql JSON.parse(response).fetch('history')
    end
  end

  context 'data & params files' do
    let(:execution_w_params) { build(:tagfinder_execution, :with_params) }

    it 'makes request to tagfinder API' do
      described_class.call(execution_w_params, connection)
      expect(connection).to have_received(:call)
    end
  end
end
