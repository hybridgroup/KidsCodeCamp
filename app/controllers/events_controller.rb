class EventsController < ApplicationController
  def index
    @events = Event.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
    @editpage = Editpage.find(4)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end
end