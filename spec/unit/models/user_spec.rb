require 'spec_helper'

describe User, type: :model do
  before :each do
    @user = User.new(username: 'username', email: 'an@email.com', password: 'hello123', password_confirmation: 'hello123')
  end
  subject { @user }

  it 'must have a unique username'

  it 'is invalid without a username' do
    should be_valid
    @user.username = ''
    should_not be_valid
  end

  it 'is invalid without a password confirmation at creation' do
    should be_valid
    @user.password_confirmation = ''
    should_not be_valid
  end

  it 'has many posts' do
    should respond_to :posts
  end
  it { should respond_to :username }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :is_admin }

=begin
  describe "abilities" do
    subject { ability }
    let(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when is an account manager" do
      let(:user){ Factory(:accounts_manager) }

      it{ should be_able_to(:manage, Account.new) }
    end
=end
end