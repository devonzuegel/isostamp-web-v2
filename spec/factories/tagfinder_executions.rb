FactoryGirl.define do
  factory :tagfinder_execution do
    user      { create(:user) }
    data_file { create(:document, user: self.user || create(:user)) }
  end
end
