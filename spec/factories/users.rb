require 'faker'

FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "#{Faker::Internet.user_name}#{n}" }
    sequence(:email) {|n| "#{Faker::Internet.email}#{n}" }
    password 'ultrasecret'
    password_confirmation { |u| u.password }
    is_admin false
  
    factory :invalid_user do
      username { Faker::Internet.user_name }
      email "invalid"
    end
  end
end