FactoryGirl.define do
  factory :document do
    id          1
    name       'MyString'
    attachment 'uploads/documents/1/testfile.mzXML'
    format     'MyString'
  end
end
