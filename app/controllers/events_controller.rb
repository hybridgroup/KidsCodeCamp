class EventsController < ApplicationController
  def index
    @events = Event.get_paginated(params[:page])
    @editpage = Editpage.get_page(:home)

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