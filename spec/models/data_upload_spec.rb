require 'rails_helper'

RSpec.describe Document, type: :model do
  it 'should have the expected FORMATS' do
    expect(Document::FORMATS).to eq %w(mzXML)
  end

  it 'should require a name' do
    expect(build(:document, name: nil)).to_not be_valid
  end

  pending 'it should require user ownership'
end
