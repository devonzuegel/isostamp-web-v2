require 'rails_helper'

RSpec.describe Tagfinder::Runner, type: :model do
  it 'makes request to tagfinder API' do
    described_class.new
  end
end
