require 'spec_helper'

describe Editpage, type: :model do
  let(:editpage){ Editpage.new(title: 'Page title', content: 'This is a content') }
  subject { editpage }

  it 'is valid with defined attributes' do
    should be_valid
  end

  it 'is invalid without a content' do
    subject.content = ''
    should_not be_valid
  end

  it { should respond_to :title }
  it { should respond_to :content }
end