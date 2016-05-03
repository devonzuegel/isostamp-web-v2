include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :document do
    kind                'Mass Spec Data'
    user                { create(:user)}
    direct_upload_url   'https://isostamp-development.s3-us-west-2.amazonaws.com/uploads/1462264055485-1ee0ylsvov0awyhj-736e836578aab4b1fbb195432aed04b4/test.mzXML'

    trait :mass_spec do
      kind              'Mass Spec Data'
    end

    trait :params do
      kind              'Parameters'
    end
  end
end
