FactoryGirl.define do
  factory :logged_event do
    tagfinder_execution nil
    log 'MyText'
  end
end
