require 'rails_helper'

RSpec.describe Session, type: :model do
  it 'must belong to a user' do
    expect(build(:session, user: nil)).to be_nil
  end
end
