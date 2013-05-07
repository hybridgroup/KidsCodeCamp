require 'spec_helper'

describe Category, type: :model do
  let(:category) { Category.new(title: 'username', description: 'This is a description') }
  subject { category }

  it 'is valid with defined attributes' do
    should be_valid
  end

  it 'is invalid without a title' do
    subject.title = ''
    should_not be_valid
  end

  it 'is invalid with a title more than 100 chars long' do
    subject.title = 'x' * 101
    should_not be_valid
  end

  it 'is invalid without description' do
    subject.description = ''
    should_not be_valid
  end

  it 'has many posts' do
    should respond_to :posts
  end

  it 'has many responses' do
    should respond_to :responses
  end

  it { should respond_to :title }
  it { should respond_to :slug }
  it { should respond_to :description }
end