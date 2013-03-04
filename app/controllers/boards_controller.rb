class BoardsController < ApplicationController
   def index
     @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])

    if @board.update_attributes(params[:board])
      redirect_to @board, notice: 'Board was successfully updated.'
    else
      render action: "edit"
    end
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(params[:board])

    if @board.save
      redirect_to @board, notice: 'Board was successfully created.' 
    else
      render action: "new"
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy

    redirect_to boards_url
  end

  def search
    @search_result_posts = Post.find_with_index(params[:search])
  end
end