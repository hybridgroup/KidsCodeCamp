class Admin::PostsController < Admin::AdminController
  layout :user_layout
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 8).order("created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

 # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
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

  # PUT /posts/1
  # PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to :after_delete_redirect, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def after_save_redirect_url
    if current_user.is_admin.zero? # Editor
      if @post.parent_id.present? # Response
        post_path(@post.parent_id)
      else
        post_path(@post)
      end
    else # Admin
      if @post.parent_id.present? # Response
        post_path(@post.parent_id)
      else
        admin_posts_path
      end
    end
  end

  def after_delete_redirect_url
    if current_user.is_admin.zero?
      if @post.parent_id.present?
        post_path(@post.parent_id)
      else
        posts_path
      end
    else # Admin
      admin_posts_path
    end
  end
end