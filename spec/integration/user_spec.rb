require 'spec_helper'

describe User, type: :model do
  let(:user){ User.new(username: 'username', email: 'an@email.com', password: 'hello123', password_confirmation: 'hello123') }

  it 'must have a unique username' do
    user2 = user.dup
    user.save
    user2.should_not be_valid
  end
end