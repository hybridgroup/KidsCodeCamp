class ContactController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(params[:contact_form])
    if @contact_form.deliver
      redirect_to({:action => 'new'}, :notice => 'Thank you for contacting us!')
    else
      render :new
    end
  end
end