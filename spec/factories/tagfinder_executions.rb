FactoryGirl.define do
  factory :tagfinder_execution do
    user nil
    data_file nil
    params_file nil
    email_sent false
    success false
  end
end
