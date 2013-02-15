class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
     @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render action: "edit"
    end
  end

  def new
    @post = Post.new(:board_id => params[:board_id])
    @post.user_id = current_user.id
    @post.parent_id = params[:parent_id]
    logger.debug "New post: #{@post.attributes.inspect}"
    if @post.parent
      @parent = @post.parent
    end
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.' 
    else
      render action: "new"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_url
  end
end
