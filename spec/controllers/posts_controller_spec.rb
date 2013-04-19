require 'spec_helper'

describe PostsController do
  describe "GET #index" do
    describe "with selected Category" do
      it "populates an array of posts" do
        category = create(:category_with_posts)
        get :index, category_id: category

        assigns(:posts).should =~ category.posts
        assigns(:categories).should be_nil
      end
      
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end

    describe "without selected Category" do
      it "populates an array of categories" do
        category = create(:category)
        category2 = create(:category)
        
        get :index
        assigns(:posts).should be_nil
        assigns(:categories).should =~ [category,category2]
      end
      
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end
  end


=begin

  describe "GET #show" do
    it "assigns the requested post to @post" do
      post = create(:post)
      get :show, id: post
      assigns(:post).should eq(post)
    end
    
    it "renders the #show view" do
      get :show, id: create(:post)
      response.should render_template :show
    end
  end


  describe "GET #new" do
    it "" do
      get :new
      response.should :success
    end

    it "render #new template" do
      get :new
      response.should render_template :new
    end
  end
  

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new post" do
        expect{
          post :create, post: attributes_for(:post)
        }.to change(Post,:count).by(1)
      end
      
      it "redirects to the new post" do
        post :create, post: attributes_for(:post)
        response.should redirect_to post_path(Post.last)
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new post" do
        expect{
          post :create, post: attributes_for(:invalid_post)
        }.to_not change(Post,:count)
      end
      
      it "re-renders the new method" do
        post :create, post: attributes_for(:invalid_post)
        response.should render_template :new
      end
    end 
  end


  describe 'PUT update' do
    before :each do
      @post = create(:post)
    end
    
    context "valid attributes" do
      it "located the requested @post" do
        put :update, id: @post, post: attributes_for(:post)
        assigns(:post).should eq(@post)      
      end
    
      it "changes @post's attributes" do
        put :update, id: @post, 
          post: attributes_for(:post, first_name: "Larry", last_name: "Smith")
        @post.reload
        @post.first_name.should eq("Larry")
        @post.last_name.should eq("Smith")
      end
    
      it "redirects to the updated post" do
        put :update, id: @post, post: attributes_for(:post)
        response.should redirect_to @post
      end
    end
    
    context "invalid attributes" do
      it "locates the requested @post" do
        put :update, id: @post, post: attributes_for(:invalid_post)
        assigns(:post).should eq(@post)      
      end
      
      it "does not change @post's attributes" do
        put :update, id: @post, 
          post: attributes_for(:post, first_name: "Larry", last_name: nil)
        @post.reload
        @post.first_name.should_not eq("Larry")
        @post.last_name.should eq("Smith")
      end
      
      it "re-renders the edit method" do
        put :update, id: @post, post: attributes_for(:invalid_post)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @post = create(:post)
    end
    
    it "deletes the post" do
        delete :destroy, id: @post
        Post.exists?(@post).should be_false
    end
      
    it "redirects to posts#index" do
      delete :destroy, id: @post
      response.should redirect_to posts_url
    end
  end
=end
end