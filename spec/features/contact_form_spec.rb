require 'spec_helper'

describe "Contact form", type: :feature do
  it "shows contact form" do
    visit contact_path
    
    page.should have_content('Contact Us')
    page.should have_css('textarea')
  end

  describe 'submits a message via contact form' do
    context 'with valid data' do
      it "sends the message" do
        visit contact_path

        fill_in 'contact_form_name', with: 'A name'
        fill_in 'contact_form_email', with: 'valid@email.com'
        fill_in 'contact_form_message', with: 'This is a message'

        page.find('#new_contact_form input[type=image]').click
        
        page.should have_content('Thank you for contacting us')
      end
    end
    context 'with invalid data' do
      it "don't send the message and notifies the errors" do
        visit contact_path

        fill_in 'contact_form_name', with: 'A name'
        fill_in 'contact_form_email', with: 'invalid@email'
        fill_in 'contact_form_message', with: 'This is a message'

        page.find('#new_contact_form input[type=image]').click
        
        page.should have_content('prevented your message from being sent')
      end
    end
  end
end