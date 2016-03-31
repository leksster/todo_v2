FactoryGirl.define do
  factory :task do
    text Faker::Hipster.sentence(7)
    deadline Faker::Time.between(DateTime.now - 300, DateTime.now)
    priority 0
    project nil
  end
end
