require 'faker'

FactoryGirl.define do
  factory :category do
    title { Faker::Name.title }
    description { Faker::Lorem.paragraph }

    factory :category_with_posts do
      after(:create) do |m, evaluator|
        FactoryGirl.create_list(:topic, 3, category: m)
      end
    end
  
    trait :invalid do
      title ""
    end
  end
end