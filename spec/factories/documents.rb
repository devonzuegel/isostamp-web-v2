FactoryGirl.define do
  factory :document do
    association :user, factory: :user
    direct_upload_url 'https://isostamp-development.s3-us-west-2.amazonaws.com/uploads/123-123-123/test.mzXML'

    after(:build) { |doc| doc.class.skip_callback(:create, :before, :set_upload_attributes) }

    trait :set_upload_attributes do
      before(:create) { |doc| doc.send(:set_upload_attributes) }
    end

    trait :mass_spec do
      kind             'Mass Spec Data'
    end

    trait :params do
      kind             'Parameters'
    end
  end
end
