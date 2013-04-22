require 'faker'

FactoryGirl.define do
  factory :post do

    title { Faker::Name.title }
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

      factory :response_with_topic do
        topic
      end
    end

    trait :invalid do
      content ""
    end
  end
end