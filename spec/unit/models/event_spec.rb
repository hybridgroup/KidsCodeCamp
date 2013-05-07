require 'spec_helper'

describe Event, type: :model do
  let(:event){ Event.new(title: 'username', content: 'This is a content') }
  subject { event }

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

  it 'is invalid without content' do
    subject.content = ''
    should_not be_valid
  end

  it { should respond_to :title }
  it { should respond_to :content }
  it { should respond_to :slug }
  
  context '#get_paginated' do
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