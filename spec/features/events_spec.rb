require 'spec_helper'

describe "Events", type: :feature do
  let(:editpage){ create(:editpage, id: 4) }
  let(:event){ create(:event) }
  subject { page }

  it "shows homepage" do
    editpage
    visit root_path
    
    should have_content(editpage.content)
  end

  it "views a event" do
    visit event_path(id: event)
    
    should have_content(event.content)
  end
end