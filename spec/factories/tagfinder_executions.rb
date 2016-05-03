FactoryGirl.define do
  factory :tagfinder_execution do
    association :user,          factory: :user
    association :data_file,     factory: :document

    trait :with_params do
      association :params_file, factory: :document
    end
  end
end
