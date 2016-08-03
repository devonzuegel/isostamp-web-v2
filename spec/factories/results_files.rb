FactoryGirl.define do
  factory :results_file do
    association :tagfinder_execution
    filename    'randomname.json'
  end
end
