# Load the rails application
require File.expand_path('../application', __FILE__)

app_environment_variables = File.join(Rails.root, 'config', 'my_app_vars.rb')
load(app_environment_variables) if File.exists?(app_environment_variables)

# Initialize the rails application
KidsCodeCamp::Application.initialize!