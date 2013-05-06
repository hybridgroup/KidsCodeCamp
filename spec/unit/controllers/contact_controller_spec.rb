require 'spec_helper'

describe ContactController, type: :controller do
  let(:contact_form){ double('ContactForm') }
  let(:valid_email){ { 'name' => 'This is my name', 'email' => 'an@email.com', 'message' => 'This is a valid message'} }
  let(:invalid_email){ valid_email[:email] = '' }
  before :each do
    ContactForm.stub(:new).and_return(contact_form)
  end
  
  describe 'GET #new' do
     it '@contact_form is empty' do
      ContactForm.should_receive(:new)

      get :new
      assigns(:contact_form).should eq(contact_form)
     end
  end

  describe 'POST #create' do
    context 'with valid data' do
      it 'delivers an email' do
        contact_form.stub(:deliver).and_return(true)

        ContactForm.should_receive(:new).with(valid_email)
        contact_form.should_receive(:deliver)

        post :create, contact_form: valid_email

        response.should redirect_to contact_path
        flash[:notice].should include 'Thank you'
      end
    end

    context 'with invalid data' do
      it 're-render template' do
        contact_form.stub(:deliver).and_return(false)

        ContactForm.should_receive(:new).with(invalid_email)
        contact_form.should_receive(:deliver)

        post :create, contact_form: invalid_email
        
        assigns(:contact_form).should eq(contact_form)
        response.should render_template :new
      end
    end
  end
end