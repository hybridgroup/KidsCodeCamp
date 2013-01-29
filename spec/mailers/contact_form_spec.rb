# describe "Contact Email" do
#   # include EmailSpec::Helpers
#   # include EmailSpec::Matchers
#   # include Rails.application.routes.url_helpers

#   before(:all) do
#     @email = ContactForm.create_contact("ashley@hybridgroup.com", "Ashley Wysocki")
#   end

#   it "should be set to be delivered to the email passed in" do
#     @email.should deliver_to("ashley@hybridgroup.com")
#   end

#   it "should contain the user's message in the mail body" do
#     @email.should have_body_text(/Ashley Wysocki/)
#   end

# end