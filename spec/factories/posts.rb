require 'faker'

FactoryGirl.define do
  factory :post do

    title { Faker::Internet.user_name }
    content { Faker::Lorem.paragraphs }
    
    user

    factory :topic do
      category
      after(:create) do |topic, evaluator|
        FactoryGirl.create_list(:response, 3, topic: topic)
      end
    end
  
    factory :response do
      title ""
    end

    trait :invalid do
      content ""
    end
  end
end