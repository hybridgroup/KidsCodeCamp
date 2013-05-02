require 'spec_helper'

describe EventsController, :type => :controller do
  describe "GET #index" do
    let(:page_number){ "1" }
    let(:paginated_events){ double("paginated_events") }
    let(:home_page){ double("home_page") }

    before :each do
      Event.stub(:get_paginated).and_return(paginated_events)
      Editpage.stub(:get_page).and_return(home_page)
    end

    it "returns paginated_events" do
      Event.should_receive(:get_paginated).with(page_number)
      
      get :index, page: page_number
      assigns(:events).should == paginated_events
    end

    it "returns home_page" do
      Editpage.should_receive(:get_page).with(:home)

      get :index
      assigns(:editpage).should == home_page
    end
  end


  describe "GET #show" do
    let(:event){ mock_model('Event') }
    let(:event_id){ "some-slug" }
    before :each do
      Event.stub(:find).with(event_id).and_return(event)
    end

    it "render #show" do
      Event.should_receive(:find).with(event_id)

      get :show, id: event_id
      assigns(:event).should == event
    end
  end
end