class ContactController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(params[:contact_form])
    if @contact_form.deliver
      flash.now[:notice] = 'Thank you!'
      redirect_to root_path
    else
      render :new
    end
  end
end