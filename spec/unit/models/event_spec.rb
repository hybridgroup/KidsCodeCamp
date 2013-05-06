require 'spec_helper'

describe Event, type: :model do
  before :each do
    @event = Event.new(title: 'username', content: 'This is a content')
  end
  subject { @event }

  it 'is invalid without a title' do
    should be_valid
    @event.title = ''
    should_not be_valid
  end

  it 'is invalid without content' do
    should be_valid
    @event.content = ''
    should_not be_valid
  end

  it 'autogenerates slug from title'

  it { should respond_to :title }
  it { should respond_to :content }
  it { should respond_to :slug }
end