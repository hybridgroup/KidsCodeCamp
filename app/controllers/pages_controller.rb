class PagesController < ApplicationController
  def home
  end

  def signup
    Pony.mail(
      :from => params[:email],
      :to => 'ron@hybridgroup.com',
      :subject => 'KidsCodeCamp Info Signup',
      :body => "#{params[:email]} wants to subscribe to the newsletter for KidsCodeCamp",
      :port => '587',
      :via => :smtp,
      :via_options => { 
        :address              => 'smtp.sendgrid.net', 
        :port                 => '25', 
        :user_name            => ENV['SENDGRID_USERNAME'], 
        :password             => ENV['SENDGRID_PASSWORD'], 
        :authentication       => 'plain', 
        :domain               => ENV['SENDGRID_DOMAIN']
      }) if Rails.env == 'production'
  end
end
