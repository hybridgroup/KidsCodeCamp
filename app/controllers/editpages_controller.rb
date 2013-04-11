class EditpagesController < ApplicationController
  def show
    @editpage = Editpage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @editpage }
    end
  end
end
