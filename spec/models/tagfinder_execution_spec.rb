require 'rails_helper'

RSpec.describe TagfinderExecution, type: :model do
  describe 'basic TagfinderExecution' do
    it 'builds a basic tagfinder_execution' do
      expect(build(:tagfinder_execution)).to be_valid
    end

    it 'requires a user' do
      expect(build(:tagfinder_execution, user: nil)).not_to be_valid
    end

    it 'requires a data_file' do
      expect(build(:tagfinder_execution, data_file: nil)).not_to be_valid
    end

    it 'allows user to upload params' do
      user = create(:user)
      expect(build(:tagfinder_execution, params_file: create(:document, user: user), user: user)).to be_valid
    end

    it 'should require the data_file to be of kind "Mass Spec Data"'
    it 'should require the params_file to be of kind "Params"'
  end
end
