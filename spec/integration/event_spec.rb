require 'spec_helper'

describe Event, type: :model do
  let(:event){ Event.new(title: 'username', content: 'This is a content') }

  it 'autogenerates slug from title' do
    event.save
    event.slug.should be
  end
end