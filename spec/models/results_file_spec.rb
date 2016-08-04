require 'rails_helper'

RSpec.describe ResultsFile, type: :model do
  describe 'Initializing ResultsFile' do
    subject { @results_file = build(:results_file) }
    it { should validate_presence_of(:filename) }
    it { should validate_presence_of(:tagfinder_execution) }

    it 'is a valid file' do
      expect(build(:results_file)).to be_valid
    end
  end
end
