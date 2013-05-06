require 'spec_helper'

describe User, type: :model do
  before :each do
    @user = User.new(username: 'username', email: 'an@email.com', password: 'hello123', password_confirmation: 'hello123')
  end

  it 'has many posts'
  it 'is invalid without a username' do
    @user.should be_valid
    @user.username = ''
    @user.should_not be_valid
  end
  
  it 'must have a unique username' do
    pending
  end

  it 'must have a password confirmation at creation' do
    @user.should be_valid
    @user.password_confirmation = ''
    @user.should_not be_valid
  end

  describe "abilities" do
    subject { ability }
    let(:ability){ Ability.new(user) }
    let(:user){ nil }

=begin
    context "when is an account manager" do
      let(:user){ Factory(:accounts_manager) }

      it{ should be_able_to(:manage, Account.new) }
    end
=end
  end
end