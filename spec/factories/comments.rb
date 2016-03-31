FactoryGirl.define do
  factory :comment do
    text Faker::Hipster.sentence(10)
    task nil
  end
end
