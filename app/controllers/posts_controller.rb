class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    conditions = {:parent_id => nil}

    if request.POST[:category].present?
      if request.POST[:category] == 'All'
        redirect_to posts_path
      else
        redirect_to :category => params[:category]
      end
      return
    elsif params[:category].present?
      conditions[:category] = params[:category]
    end

    @posts = Post.where(conditions).paginate(:page => params[:page], :per_page => 8)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @current_post = Post.find(params[:id])
    @posts = Post.where(:parent_id => params[:id]).paginate(:page => params[:page], :per_page => 3)
    @post = Post.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end
end
