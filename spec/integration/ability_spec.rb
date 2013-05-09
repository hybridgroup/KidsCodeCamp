require 'spec_helper'
require "cancan/matchers"

describe Ability, ability: true do
  let(:ability){ Ability.new(user) }
  subject { ability }

  context 'As a guest user' do
    let(:user){ nil }
    it 'can read All' do
      should be_able_to(:read, :all)
    end
  end

  context 'As an Logged in user' do
    let(:user){ create(:user, is_admin: false) }
    
    it 'can new Posts' do
      should be_able_to(:new, Post)
    end
    it 'can create Posts' do
      should be_able_to(:create, Post)
    end
    
    context 'As an Editor user' do
      it 'can edit his Posts' do
        should be_able_to(:edit, Post, :user_id => user.id)
      end
      it 'can update his Posts' do
        should be_able_to(:update, Post, :user_id => user.id)
      end
      it 'can destroy his Posts' do
        should be_able_to(:destroy, Post, :user_id => user.id)
      end
    end

    context 'As an Admin user' do
      let(:user){ create(:user, is_admin: true) }
      it 'can edit Posts' do
        should be_able_to(:edit, Post)
      end
      it 'can update Posts' do
        should be_able_to(:update, Post)
      end
      it 'can destroy Posts' do
        should be_able_to(:destroy, Post)
      end
    end
  end
end