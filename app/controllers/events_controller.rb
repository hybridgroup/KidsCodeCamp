class EventsController < ApplicationController
	def index
	end

	def new
	  @event = Event.new
	 
	  respond_to do |format|
	    format.html  # new.html.erb
	    format.json  { render :json => @event }
	  end
	end

	def create
		debug params
	  @event = Event.new(params[:event])
	 
	  respond_to do |format|
	    if @event.save
	      format.html  { redirect_to(@event,
	                    :notice => 'Event was successfully created.') }
	      format.json  { render :json => @event,
	                    :status => :created, :location => @event }
	    else
	      format.html  { render :action => "new" }
	      format.json  { render :json => @event.errors,
	                    :status => :unprocessable_entity }
	    end
	  end
	end

end