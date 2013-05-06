require 'spec_helper'

describe EditpagesController, type: :controller do
  describe "GET #show" do
    let(:editpage){ double('Editpage') }
    let(:page_name){ "tools" }
    
    before :each do
      Editpage.stub(:get_page).and_return(editpage)
    end

    context 'when a valid page is requested' do
      it "@editpage.present?" do
        Editpage.should_receive(:get_page).with(page_name)
        get :show, { id: page_name }
        assigns(:editpage).should eq(editpage)
      end
    end
  end
end