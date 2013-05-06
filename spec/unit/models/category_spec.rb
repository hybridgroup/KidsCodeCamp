require 'spec_helper'

describe Category, type: :model do
  before :each do
    @category = Category.new(title: 'username', description: 'This is a description')
  end
  subject { @category }

  it 'is invalid without a title' do
    should be_valid
    @category.title = ''
    should_not be_valid
  end

  it 'is invalid with a title more than 100 chars long' do
    should be_valid
    @category.title = 'x' * 101
    should_not be_valid
  end

  it 'is invalid without description' do
    should be_valid
    @category.description = ''
    should_not be_valid
  end

  it 'autogenerates slug from title'

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