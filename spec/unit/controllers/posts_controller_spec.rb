require 'spec_helper'

# Before filters

shared_examples_for "set_category" do
  before :each do
    Category.stub(:find).and_return(category)
  end

  it "populates @category with the current category" do
    Category.should_receive(:find).with(category_id)

    #get action.to_sym, category_id: category_id
    make_request
    assigns(:category).should == category
  end
end

=begin
shared_examples_for "check_category" do
  it "should receive check_category before filter" do
    controller.should_receive(:check_category)

    make_request
  end
end
=end


###

describe PostsController, type: :controller do
  let(:signed_user){ create(:user) }
  let(:signed_admin_user){ create(:user, is_admin: true) }
  let(:category_id) { "category-slug" }
  let(:category) { double('Category') }

  before :each do
    Category.stub(:find).with(category_id).and_return(category)
  end

  describe "GET #index" do
    let(:page_number) { "1" }
    let(:paginated_posts) { double('paginated_posts') }
    let(:all_categories) { double('all_categories') }

    before :each do
      Category.stub(:find).and_return(category)
      Category.stub(:all).and_return(all_categories)

      Post.stub(:get_paginated_for_category).with(category,anything()).and_return(paginated_posts)
    end

    it_should_behave_like "set_category" do
      let(:make_request) { get :index, category_id: category_id }
    end

    context "with selected Category" do
      it "@categories.nil? and @posts is a collection" do
        Category.should_receive(:find).with(category_id)
        Post.should_receive(:get_paginated_for_category).with(category,anything())

        get :index, category_id: category_id

        assigns(:posts).should == paginated_posts
      end
    end

    context "without selected Category" do
      it "@posts.nil? and @categories is a collection" do
        Category.should_receive(:all)
        
        get :index

        assigns(:posts).should be_nil
        assigns(:categories).should == all_categories
      end
    end
  end


  describe "GET #show" do
    let(:post_id){ "post-slug" }
    let(:category_id){ "category-slug" }

    let(:category){ double('Category') }
    let(:new_post){ double('Post') }
    let(:current_post){ double('Post') }
    let(:paginated_responses){ double('paginated_responses') }
    let(:current_post){ double('current_post') }
    let(:show_post){ get :show, id: post_id, category_id: category_id }

    before :each do
      Category.stub(:find).with(category_id).and_return(category)

      Post.stub(:find).with(post_id).and_return(current_post)
      Post.stub(:new).and_return(new_post)
      Post.stub(:get_paginated_for_topic).with(current_post,anything()).and_return(paginated_responses)
    end

    it_should_behave_like "set_category" do
      let(:make_request) { show_post }
    end

    it "assigns the requested main post to @current_post" do
      Post.should_receive(:find).with(post_id).and_return(current_post)
      
      show_post
      assigns(:current_post).should eq(current_post)
    end

    it "assigns @current_post responses to posts" do
      Post.should_receive(:get_paginated_for_topic).with(current_post, anything()).and_return(paginated_responses)
      
      show_post
      assigns(:posts).should eq(paginated_responses)
    end

    it "assigns empty post to @new_post" do
      Post.should_receive(:new).and_return(new_post)
      
      show_post
      assigns(:post).should eq(new_post)
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
  
=begin

  describe "POST #create" do
    let(:category){ create(:category) }
    let(:post_create){ put :create, post: attributes_for(:post, user_id: signed_user, category_id: category.id), category_id: category }
    let(:invalid_post_create){ put :create, post: attributes_for(:post,:invalid, user_id: signed_user, category_id: category.id), category_id: category }

    context "user_signed_in?" do
      before :each do
        set_user_session(signed_user)
      end

      context "@category.present?" do
        context "@post.valid?" do
          it "post.save" do
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
              invalid_post_create
            }.to_not change(Post,:count)
          end
          
          it "re-renders #new" do
            invalid_post_create
            response.should render_template :new
          end
        end
      end

      context "@category.nil?" do
        it "redirect_to posts_path" do
          expect {
            post :create, post: attributes_for(:post, user_id: signed_user, category_id: category.id)
          }.to raise_error(ActionController::RoutingError)
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

  describe "PUT #update" do
    let(:topic){ create(:topic) }
    let(:resp){ create(:response_with_topic) }
    let(:category){ create(:category) }

    let(:topic_update){ put :update, post: attributes_for(:topic, title: "updated", user_id: signed_user, category_id: category.id), category_id: topic.category, id: topic }
    let(:invalid_topic_update){ put :update, post: attributes_for(:topic, :invalid, title: "updated", user_id: signed_user, category_id: category.id), category_id: topic.category, id: topic }
    
    let(:response_update){ put :update, post: attributes_for(:response_with_topic, title: "updated", user_id: signed_user, category_id: category.id), category_id: resp.topic.category, id: resp }
    let(:invalid_response_update){ put :update, post: attributes_for(:response_with_topic, :invalid, title: "updated", user_id: signed_user, category_id: category.id), category_id: resp.topic.category, id: resp }

    context "user_signed_in?" do
      before :each do
        set_user_session(signed_user)
      end

      context "@category.present?" do
        it "@post == Post.find(params[:id])" do
          topic_update
          assigns(:post).should eq(topic)
        end

        context "@post.valid?" do
          context "current_user.is_admin?" do
            before :each do
              set_user_session(signed_admin_user)
            end

            it "post.title == 'updated'" do
              expect{
                topic_update
                topic.reload
              }.to change{ topic.title }.to('updated')
            end
            
            context "@post.parent_id?" do
              it "redirect_to category_post_path(@post.topic.category,@post.topic)" do
                response_update
                resp.reload
                response.should redirect_to category_post_path(resp.topic.category,resp.topic)
              end
            end

            context "!@post.parent_id?" do
              it "redirect_to category_post_path(@post)" do
                topic_update
                topic.reload
                response.should redirect_to category_post_path(topic.category,topic)
              end
            end
          end # @current_user.is_admin?

          context "!current_user.is_admin?" do
            context "@post.user == current_user" do
              let(:topic){ create(:topic, user: signed_user) }
              let(:resp){ create(:response_with_topic, user: signed_user) }

              it "post.title == 'updated'" do
                expect{
                  topic_update
                  topic.reload
                }.to change{ topic.title }.to('updated')
              end
              
              context "@post.parent_id?" do
                it "redirect_to category_post_path(@post.topic.category,@post.topic)" do
                  response_update
                  response.should redirect_to category_post_path(resp.topic.category,resp.topic)
                end
              end

              context "!@post.parent_id?" do
                it "redirect_to category_post_path(@post)" do
                  topic_update
                  topic.reload
                  response.should redirect_to category_post_path(topic.category,topic)
                end
              end
            end # @post.user == current_user

            context "@post.user != current_user" do
              it "redirect_to posts_path" do
                topic_update
                response.should redirect_to posts_path
              end
            end
          end
        end # @post.valid

        context "!@post.valid?" do
          context "current_user.is_admin?" do
            before :each do
              set_user_session(signed_admin_user)
            end

            it "post.title != 'updated'" do
              expect{
                invalid_topic_update
                topic.reload
              }.to_not change{ topic.title }.to('updated')
            end
            
            context "@post.parent_id?" do
              it "render_template #update" do
                invalid_topic_update
                response.should render_template :edit
              end
            end

            context "!@post.parent_id?" do
              it "render_template #update" do
                invalid_topic_update
                response.should render_template :edit
              end
            end
          end # current_user.is_admin?
          
          context "!current_user.is_admin?" do
            context "@post.user == current_user" do
              let(:topic){ create(:topic, user: signed_user) }
              let(:resp){ create(:response_with_topic, user: signed_user) }

              it "post.title != 'updated'" do
                expect{
                  invalid_topic_update
                  topic.reload
                }.to_not change{ topic.title }.to('updated')
              end
              
              context "@post.parent_id?" do
                it "render_template #update" do
                  invalid_response_update
                  response.should render_template :edit
                end
              end

              context "!@post.parent_id?" do
                it "render_template #update" do
                  invalid_topic_update
                  response.should render_template :edit
                end
              end
            end # @post.user == current_user

            context "@post.user != current_user" do
              it "redirect_to posts_path" do
                topic_update
                response.should redirect_to posts_path
              end
            end # @post.user != current_user
          end # !current_user.is_admin?
        end
      end

      context "@category.nil?" do
        it "redirect_to posts_path" do
          expect{
            put :update, post: attributes_for(:topic, user_id: signed_user, category_id: category.id), id: topic
          }.to raise_error(ActionController::RoutingError)
        end
      end
    end
    
    context "!user_signed_in?" do
      it "redirect_to login_path" do
        topic_update
        response.should redirect_to login_path
      end
    end
  end

  describe 'DELETE destroy' do
    let(:topic) { create(:topic) }
    let(:resp) { create(:response_with_topic) }
    
    context "user_signed_in?" do
      before :each do
        set_user_session(signed_user)
      end

      context "current_user.is_admin?" do
        before :each do
          set_user_session(signed_admin_user)
        end

        it "deletes the post" do
          delete :destroy, id: topic, category_id: topic.category
          Post.exists?(topic).should be_false
        end

        context "post.parent_id?" do
          it "redirects to posts#index" do
            delete :destroy, id: resp, category_id: resp.topic.category
            response.should redirect_to category_post_path(resp.topic.category,resp.topic)
          end
        end

        context "!post.parent_id?" do
          it "redirects to posts#index" do
            delete :destroy, id: topic, category_id: topic.category
            response.should redirect_to category_posts_path(topic.category)
          end
        end
      end

      context "!current_user.is_admin?" do
        context "@post.user == current_user" do
          let(:topic){ create(:topic, user: signed_user) }
          let(:resp){ create(:response_with_topic, user: signed_user) }

          it "deletes the post" do
            delete :destroy, id: topic, category_id: topic.category
            Post.exists?(topic).should be_false
          end

          context "post.parent_id?" do
            it "redirects to posts#index" do
              delete :destroy, id: resp, category_id: resp.topic.category
              response.should redirect_to category_post_path(resp.topic.category,resp.topic)
            end
          end

          context "!post.parent_id?" do
            it "redirects to posts#index" do
              delete :destroy, id: topic, category_id: topic.category
              response.should redirect_to category_posts_path(topic.category)
            end
          end
        end

        context "@post.user != current_user" do
          it "redirect_to posts_path" do
            delete :destroy, id: topic, category_id: topic.category
            response.should redirect_to posts_path
          end
        end
      end
    end

    context "!user_signed_in?" do
      it "redirect_to login_path" do
        delete :destroy, id: topic, category_id: topic.category
        response.should redirect_to login_path
      end
    end
  end
=end
end