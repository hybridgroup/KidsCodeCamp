class PagesController < ApplicationController
  def about
  end

  def signup
    if ENV['MAILCHIMP_API_KEY'] and ENV['MAILCHIMP_LIST']
      @mailchimp ||= Hominid::API.new(ENV['MAILCHIMP_API_KEY'])
      @mailchimp.list_subscribe(ENV['MAILCHIMP_LIST'], params[:email], '', 'html', true, true, true, false)
    end
  end
end
