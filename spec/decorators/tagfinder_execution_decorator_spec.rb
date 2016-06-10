require 'spec_helper'

describe TagfinderExecutionDecorator do
  describe 'status' do
    before { Document.any_instance.stub(:set_upload_attributes).and_return(true) }

    it 'should be decorated with the expected decorator' do
      @te = build(:tagfinder_execution).decorate
      @te.should be_decorated_with TagfinderExecutionDecorator
    end

    it 'should be "Still running..." when success is not yet defined' do
      @te = build(:tagfinder_execution).decorate
      expect(@te.status).to eq("Still running...")
    end

    it 'should be "Success!" when success is true' do
      @te = create(:tagfinder_execution, success: true).decorate
      expect(@te.status).to eq("Success!")
    end

    it 'should be "Failure" when success is false' do
      @te = create(:tagfinder_execution, success: false).decorate
      expect(@te.status).to eq("Failure")
    end
  end
end
