FactoryGirl.define do
  factory :task do
    text "MyString"
    deadline "2016-03-21"
    priority 1
    project nil
  end
end
