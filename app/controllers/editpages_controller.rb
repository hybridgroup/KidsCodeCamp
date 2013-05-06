class EditpagesController < ApplicationController
  def show
    @editpage = Editpage.get_page(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @editpage }
    end
  end
end
