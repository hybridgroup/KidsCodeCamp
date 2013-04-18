require 'faker'

FactoryGirl.define do
  factory :post do
    title { Faker::Internet.user_name }
    content { Faker::Internet.email }
    category
    user
    responses
    is_admin true
  end

  factory :invalid_post, parent: :post do
    title ""
  end
end