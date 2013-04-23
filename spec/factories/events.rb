require 'faker'

FactoryGirl.define do
  factory :event do
    title { Faker::Name.title }
    content { Faker::Lorem.paragraphs }
    
    trait :invalid do
      content ""
    end
  end
end