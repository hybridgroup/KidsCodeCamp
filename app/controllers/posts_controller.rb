class PostsController < ApplicationController
  load_and_authorize_resource
  before_filter :carry

  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  def index
    @category_list = false
    if params[:category].present?
      conditions = {:parent_id => nil, :category_id => Category.find(params[:category]).id}
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
    @posts = Post.where(:parent_id => params[:id]).paginate(:page => params[:page], :per_page => 8).order("created_at")
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
    #authorize! :create, @post

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
      post_path(@post.parent_id)
    else
      post_path(@post)
    end
  end
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  def after_delete_redirect_url
    if @post.parent_id.present? #Response
      post_path(@post.parent_id)
    else
      posts_path
    end
  end
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  def url_options
    if @post.parent_id.present? #Response
      post_path(@post.parent_id)
    else
      posts_path
    end
  end
end