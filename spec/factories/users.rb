require 'faker'

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'ultrasecret'
    confirm 'ultrasecret'

    factory :admin do
      admin true
    end
  end
end