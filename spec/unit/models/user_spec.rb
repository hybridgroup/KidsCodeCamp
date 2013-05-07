require 'spec_helper'

describe User, type: :model do
  let(:user){ User.new(username: 'username', email: 'an@email.com', password: 'hello123', password_confirmation: 'hello123') }
  subject { user }

  it 'is valid with defined attributes' do
    should be_valid
  end

  it 'is invalid without a username' do
    subject.username = ''
    should_not be_valid
  end

  it 'is invalid without a password confirmation at creation' do
    subject.password_confirmation = ''
    should_not be_valid
  end

  it 'has many posts' do
    should respond_to :posts
  end
  
  it { should respond_to :username }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :is_admin }
end