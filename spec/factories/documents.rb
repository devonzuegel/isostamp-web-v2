include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :document do
    attachment { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'test.mzXML')) }
    kind       'Mass Spec Data'
    user       { create(:user)}

    trait :mass_spec do
      kind       'Mass Spec Data'
    end

    trait :params do
      kind       'Parameters'
    end
  end
end
