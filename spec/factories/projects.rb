FactoryGirl.define do
  factory :project do
    name Faker::Hipster.sentence(5)
  end
end
