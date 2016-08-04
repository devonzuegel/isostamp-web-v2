FactoryGirl.define do
  factory :history_output do
    command 'MyText'
    status 1
    tagfinder_execution nil
    stderr 'MyText'
    stdout 'MyText'
  end
end
