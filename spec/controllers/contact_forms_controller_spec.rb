# describe "POST /contact" do
# 	include EmailSpec::Helpers
#   include EmailSpec::Matchers
#   include Rails.application.routes.url_helpers
#   it "should deliver the signup email" do
#     # expect
#     ContactForm.should_receive(:deliver_signup).with("ashley@hybridgroup.com", "Ashley")
#     # when
#     post :contact, "Email" => "ashley@hybridgroup.com", "Name" => "Ashley"
#   end
# end
