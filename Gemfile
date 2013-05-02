source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'devise'
gem 'cancan'
gem 'mail_form'
gem 'will_paginate', '~> 3.0.0'
gem 'friendly_id'
gem 'rails_admin'
gem "haml"
gem "haml-rails"
gem "redcarpet"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem "compass", "~> 0.12.2"
  gem 'compass-rails'
  gem 'jquery-rails'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'pry'
  gem 'nifty-generators'
  gem "better_errors"
end

# To use debugger
group :development,:test do
  gem 'debugger'
  gem 'sqlite3'
  gem "rspec-rails"
  gem "guard-livereload"
end

group :test do
  gem "factory_girl_rails"
  gem "guard-rspec"
  gem "capybara"
  gem 'rb-fsevent', '~> 0.9'
  gem 'faker'
  gem "database_cleaner"
  gem 'mocha'
  gem 'launchy'
  gem 'email_spec'
end