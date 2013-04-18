require 'faker'

FactoryGirl.define do
  factory :admin_user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'ultrasecret'
    password_confirmation 'ultrasecret'
    is_admin true
  end

  factory :user, parent: :admin_user do
    is_admin false
  end

  factory :invalid_user, parent: :admin_user do
    username { Faker::Internet.user_name }
    email "invalid"
  end
end