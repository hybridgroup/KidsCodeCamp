require 'spec_helper'

describe EventsController do
  describe "GET #index" do
    before :each do
      create(:editpage, id: 4)
    end

    it "render #index" do
      get :index
      response.should render_template :index
    end

    it "@events.present?" do
      get :index
      assigns(:events).should =~ Event.paginate(page: 1, per_page: 10).order('created_at DESC')
    end

    it "@editpage.present?" do
      get :index
      assigns(:editpage).should_not be_nil
    end
  end


  describe "GET #show" do
    let(:event){ create(:event) }

    it "render #show" do
      get :show, id: event
      response.should render_template :show
    end

    it "@event.present?" do
      get :show, id: event
      assigns(:event).should eq(event)
    end
  end
end