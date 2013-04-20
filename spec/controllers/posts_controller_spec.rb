require 'spec_helper'

describe PostsController do
  describe "GET #index" do
    let(:category) { create(:category) }

    it "render #index" do
      get :index
      response.should render_template :index
    end

    context "with selected Category" do
      it "@categories.nil? and @posts is a collection" do
        category = create(:category_with_posts)

        get :index, category_id: category

        assigns(:categories).should be_nil
        assigns(:posts).should =~ category.posts
      end
    end

    context "without selected Category" do
      it "@posts.nil? and @categories is a collection" do
        category = create(:category)
        category2 = create(:category)
        
        get :index

        assigns(:posts).should be_nil
        assigns(:categories).should =~ [category,category2]
      end
    end
  end


  describe "GET #show" do
    let(:post){ create(:topic) }
    let(:show_post){ get :show, id: post, category_id: post.category }

    it "render #show" do
      show_post
      response.should render_template :show
    end

    it "assigns the requested main post to @current_post" do
      show_post
      assigns(:current_post).should eq(post)
    end

    it "assigns the post's responses to @posts" do
      show_post
      assigns(:posts).should =~ post.responses
    end
  end


  describe "GET #new" do
    context "user_signed_in?" do
      before :each do
        set_user_session(create(:user))
      end

      context "@category.nil?" do
        it "redirect_to posts_path" do
          get :new
          response.should redirect_to posts_path
        end
      end

      context "!@category.nil?" do
        let(:get_new_post) { get :new, category_id: create(:category) }

        it "response.should be_success" do
          get_new_post
          response.should be_success
        end

        it "render #new" do
          get_new_post
          response.should render_template :new
        end

        it "@post.new_record?" do
          get_new_post
          assigns(:post).should be_new_record
        end
      end
    end

    context "!user_signed_in?" do
      it "redirect_to login_path" do
        get :new
        response.should redirect_to login_path
      end
    end
  end
  

  describe "POST #create" do
    let(:signed_user){ create(:user) }
    let(:category){ create(:category) }
    let(:post_create){ post :create, post: attributes_for(:post, user_id: signed_user, category_id: category.id), category_id: category }
    let(:post_create_invalid){ post :create, post: attributes_for(:post,:invalid, user_id: signed_user, category_id: category.id), category_id: category }

    context "user_signed_in?" do
      before :each do
        set_user_session(signed_user)
      end

      context "@category.present?" do
        context "@post.valid?" do
          it "post.save" do
            atts = attributes_for(:topic)
            expect{
              post_create
            }.to change(Post,:count).by(1)
          end
          
          it "redirects to the new post" do
            post_create
            post = Post.last
            response.should redirect_to category_post_path(post.category,post)
          end
        end

        context "!@post.valid?" do
          it "!post.save" do
            expect{
              post_create_invalid
            }.to_not change(Post,:count)
          end
          
          it "re-renders #new" do
            post_create_invalid
            response.should render_template :new
          end
        end
      end

      context "@category.nil?" do
        it "redirect_to posts_path" do
          post :create, post: attributes_for(:post, user_id: signed_user, category_id: category.id), category_id: category
          response.should_not be_success
        end
      end
    end
    
    context "!user_signed_in?" do
      it "redirect_to login_path" do
        post_create
        response.should redirect_to login_path
      end
    end
  end

=begin

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
        put :update, id: @post, post: attributes_for(:post,:invalid)
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
        put :update, id: @post, post: attributes_for(:post,:invalid)
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