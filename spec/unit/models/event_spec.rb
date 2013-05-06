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

  it 'is invalid with a title more than 100 chars long' do
    should be_valid
    @event.title = 'x' * 101
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
  
  context 'class methods' do
    let(:page_number){ "1" }
    let(:events){ double('Event') }

    before :each do
      Event.stub(:paginate).and_return(events)
    end
    
    it 'returns paginated' do
      Event.should_receive(:paginate).with(page: page_number, per_page: 10)
      events.should_receive(:order).with('created_at DESC')

      Event.get_paginated(page_number)
    end
  end
end