require 'rails_helper'

RSpec.describe DataUpload, type: :model do
  it 'should have the expected FORMATS' do
    expect(DataUpload::FORMATS).to eq %w(mzXML)
  end

  it 'should require a name' do
    expect(build(:data_upload, name: nil)).to_not be_valid
  end

  pending 'it should require user ownership'
end
