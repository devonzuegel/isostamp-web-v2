require 'rails_helper'

RSpec.describe DataUpload, type: :model do
  it 'should have the expected FORMATS' do
    expect(DataUpload::FORMATS).to eq %w(mzXML)
  end
end
