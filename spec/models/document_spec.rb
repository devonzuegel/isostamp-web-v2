require 'rails_helper'

RSpec.describe Document, type: :model do
  it 'builds a basic document' do
    expect(build(:document)).to be_valid
  end

  it 'it should require user ownership' do
    expect(build(:document, user: nil)).not_to be_valid
  end

  it 'is destroyed when its owner is destroyed' do
    user = create(:user)
    expect { create(:document, user: user) }.to change { Document.count }.by 1
    expect { user.destroy }.to change { Document.count }.by -1
  end
end
