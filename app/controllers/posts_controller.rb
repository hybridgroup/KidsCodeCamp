class PostsController < ApplicationController
  load_and_authorize_resource
  before_filter :set_category

  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  def index
    @category_list = false
    if params[:category_id].present?
      conditions = {:parent_id => nil, :category_id => Category.find(params[:category_id]).id}
      @posts = Post.where(conditions).paginate(:page => params[:page], :per_page =>12).order('created_at DESC')
    else
      @categories = Category.all
      @category_list = true
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  def show
    @current_post = Post.find(params[:id])
    @posts = Post.where(:parent_id => @current_post.id).paginate(:page => params[:page], :per_page => 8).order("created_at")
    @post = Post.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  def edit
    @post = Post.find(params[:id])
    #authorize! :edit, @post
  end
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  def create
    params[:post][:user_id] = current_user.id if params[:post][:user_id].nil?
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to :after_save_redirect, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to :after_save_redirect, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to :after_delete_redirect, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end 
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  def after_save_redirect_url
    if @post.parent_id.present? # Response
      category_post_path(@post.topic.category,@post.topic)
    else
      category_post_path(@post.category,@post)
    end
  end
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  def after_delete_redirect_url
    if @post.parent_id.present? #Response
      category_post_path(@post.topic.category,@post.topic)
    else
      category_posts_path(@post.category)
    end
  end
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  def set_category
    @category = Category.find(params[:category_id]) if params[:category_id].present?
  end
  
end