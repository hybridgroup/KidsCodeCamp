require 'spec_helper'

describe EditpagesController do
  let(:about_page){ create(:editpage, id: 1) }
  let(:tools_page){ create(:editpage, id: 2) }
  let(:lessons_page){ create(:editpage, id: 3) }

  describe "GET #show" do
    context 'about page' do
      it "renders view" do
        get :show, { id: 1 }
        response.should be 200
      end

      it "@editpage.present?" do
        get :show, { id: 1 }
        assigns(:editpage).should_not be_nil
      end
    end

    context 'tools page' do
      it "renders view" do
        get :show, { id: 2 }
        response.should be 200
      end

      it "@editpage.present?" do
        get :show, { id: 2 }
        assigns(:editpage).should_not be_nil
      end
    end

    context 'lessons page' do
      it "renders view" do
        get :show, { id: 2 }
        response.should be 200
      end

      it "@editpage.present?" do
        get :show, { id: 2 }
        assigns(:editpage).should_not be_nil
      end
    end
  end
end