require 'faker'

FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "#{Faker::Internet.user_name}#{n}" }
    sequence(:email) {|n| "#{Faker::Internet.email}#{n}" }
    password 'ultrasecret'
    password_confirmation { |u| u.password }
    is_admin false
  
    trait :invalid do
      email "invalid"
    end
  end
end