class PostsController < ApplicationController
  load_and_authorize_resource
  before_filter :set_category
  before_filter :check_category, only: [:new, :edit, :show, :create, :update]

  def index
    if params[:category_id].present?
      @posts = Post.get_paginated_for_category(Category.find(params[:category_id]), params[:page])
    else
      @posts = nil 
      @categories = Category.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end
  
  
  def show
    @current_post = Post.find(params[:id])
    @posts = Post.get_paginated_for_topic(@current_post, params[:page])
    @post = Post.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end
  
  
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end
  
  
  def edit
    @post = Post.find(params[:id])
    #authorize! :edit, @post
  end
  
  
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
  
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to :after_delete_redirect, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end 
  
  
  def after_save_redirect_url
    if @post.parent_id.present? # Response
      category_post_path(@post.topic.category,@post.topic)
    else
      category_post_path(@post.category,@post)
    end
  end
  
  
  def after_delete_redirect_url
    if @post.parent_id.present? #Response
      category_post_path(@post.topic.category,@post.topic)
    else
      category_posts_path(@post.category)
    end
  end
  
  
  def set_category
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
    end
  end

  def check_category
    redirect_to posts_path if @category.nil?
  end
  
end