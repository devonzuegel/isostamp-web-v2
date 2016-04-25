require 'rails_helper'

RSpec.describe Document, type: :model do
  it 'should build a basic document' do
    expect(build(:document)).to be_valid
  end

  it 'should require an attachment' do
    expect(build(:document, attachment: nil)).to_not be_valid
  end

  it 'should require a defined kind' do
    expect(build(:document, kind: nil)).to_not be_valid
  end

  it 'it should require user ownership' do
    expect(build(:document, user: nil)).to_not be_valid
  end
end
