class ToolsController < ApplicationController
  before_filter :authenticate_admin!, :except => [:show, :index]

  def index
  	@categories = Category.all
		@tools = Tool.all
  end

  def show
    @tool = Tool.find(params[:id])
  end

  def edit
    @tool = Tool.find(params[:id])
  end

  def update
    @tool = Tool.find(params[:id])

    if @tool.update_attributes(params[:tool])
      redirect_to @tool, notice: 'tool was successfully updated.'
    else
      render action: "edit"
    end
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(params[:tool])

    if @tool.save
      redirect_to @tool, notice: 'tool was successfully created.' 
    else
      render action: "new"
    end
  end

  def destroy
    @tool = Tool.find(params[:id])
    @tool.destroy

    redirect_to tools_url
  end

end
