require 'rails_helper'

RSpec.describe Session, type: :model do
  let(:user) { create(:user) }

  it 'creates a new session' do
    expect { create(:session, user: user) }.to change { Session.count }.by 1
  end

  it 'must belong to a user' do
    expect(build(:session, user: nil)).not_to be_valid
  end
end
