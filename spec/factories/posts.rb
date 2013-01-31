# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title ""
    user_id "MyString"
    board_id "MyString"
    body "MyText"
  end
end
