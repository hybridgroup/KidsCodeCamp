require 'spec_helper'

describe "Events" do
  let(:editpage){ create(:editpage, id: 4) }
  let(:event){ create(:event) }

  it "show homepage" do
    visit root_path
    
    page.should have_content(editpage.content)
  end

  it "views a event" do
    visit event_path(id: event)
    
    page.should have_content(event.title)
  end
end