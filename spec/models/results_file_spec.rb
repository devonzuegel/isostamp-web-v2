require 'rails_helper'

RSpec.describe ResultsFile, type: :model do
  describe 'Initializing ResultsFile' do
    subject { @results_file = build(:results_file)         }
    it { should validate_presence_of(:tmp_filepath)        }
    it { should validate_presence_of(:filename)            }
    it { should validate_presence_of(:tagfinder_execution) }
  end

  it 'should require you to define a non-blank filename' do
    expect(build(:results_file, tmp_filepath: nil)).to_not be_valid
    expect(build(:results_file, tmp_filepath: '')).to_not be_valid
  end

  describe 'the filepath' do
    it 'should be a valid file' do
      expect(build(:results_file)).to be_valid
    end

    it 'should not be a directory' do
      expect(build(:results_file, tmp_filepath: nil)).to_not be_valid
    end

    it 'should exist' do
      expect(build(:results_file, tmp_filepath: nil))            .to_not be_valid
      expect(build(:results_file, tmp_filepath: ''))             .to_not be_valid
      expect(build(:results_file, tmp_filepath: 'fasdfasdfasfd')).to_not be_valid
    end
  end

  describe '#s3_key' do
    it 'should return the expected s3 key' do
      filename = 'blah.txt'
      results_file = build(:results_file, filename: filename)
      hex_base     = results_file.tagfinder_execution.hex_base
      expect(results_file.s3_key).to eq "results/#{hex_base}/#{filename}"
    end
  end
end