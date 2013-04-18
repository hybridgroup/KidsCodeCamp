require 'faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'ultrasecret'
    password_confirmation 'ultrasecret'
    is_admin true
  end

  factory :editor_user, parent: :user do
    is_admin false
  end

  factory :invalid_user, parent: :user do
    username { Faker::Internet.user_name }
    email "invalid"
  end
end