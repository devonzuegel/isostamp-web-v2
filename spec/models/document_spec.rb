require 'rails_helper'

RSpec.describe Document, type: :model do
  it 'should build a basic document' do
    expect(build(:document)).to be_valid
  end

  it 'it should require user ownership' do
    expect(build(:document, user: nil)).to_not be_valid
  end

  it 'should be destroyed when its owner is destroyed' do
    user = create(:user)
    expect { create(:document, user: user) }.to change { Document.count }.by 1
    expect { user.destroy }.to change { Document.count }.by -1
  end
end
