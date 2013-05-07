require 'faker'

FactoryGirl.define do
  factory :editpage do
    title { Faker::Name.title }
    content { Faker::Lorem.paragraphs }
    
    trait :invalid do
      content ""
    end
    trait :home do
      id 4
    end
    trait :about do
      id 1
    end
    trait :tools do
      id 2
    end
    trait :lessons do
      id 3
    end
  end
end