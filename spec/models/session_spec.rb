require 'rails_helper'

RSpec.describe Session, type: :model do
  let(:user) { create(:user) }

  it 'should create a new session' do
    expect { create(:session, user: user) }.to change { Session.count }.by 1
  end

  it 'must belong to a user' do
    expect(build(:session, user: nil)).to_not be_valid
  end
end
