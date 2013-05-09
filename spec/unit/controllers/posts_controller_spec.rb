require 'spec_helper'

describe PostsController, type: :controller do
  let(:category) { mock_model('Category', id: 1, slug: category_id) }
  let(:category_id) { "category-slug" }

  let(:xpost) { mock_model('Post', id: 1, slug: post_id, user_id: 1) }
  let(:post_id){ "post-slug" }

  let(:resp){ mock_model('Post', parent_id: xpost.id, slug: resp_id, user_id: 1) }
  let(:resp_id){ "resp-id" }
  
  let(:page_number) { "1" }
  let(:valid_atts){ {'title'=>'Title', 'content'=>'This is a content', 'user_id'=>'1' , 'category_id'=>'1'} }

  before :each do
    Category.stub(:find).with(category_id).and_return(category)
  end

  describe "set_category filter" do
    it 'assigns @category to the current when category_id is present' do
      Category.should_receive(:find).with(category_id)
      
      get :index, category_id: category_id
      assigns(:category).should eq(category)
    end

    it 'assigns @category to nil when no category_id is specified' do
      Category.should_not_receive(:find)

      get :index
      assigns(:category).should be_nil
    end
  end


  describe "#index" do
    let(:paginated_posts) { double('paginated_posts') }
    let(:all_categories) { double('all_categories') }

    before :each do
      Category.stub(:all).and_return(all_categories)
      Post.stub(:get_paginated_for_category).with(category,page_number).and_return(paginated_posts)
    end

    context "when have selected a category" do
      it "@posts.nil? and @categories is a collection" do
        Category.should_receive(:all)
        
        get :index

        assigns(:posts).should be_nil
        assigns(:categories).should == all_categories
      end
    end

    context "when have no selected category" do
      it "@categories.nil? and @posts is a collection" do
        Category.should_receive(:find).with(category_id)
        Post.should_receive(:get_paginated_for_category).with(category,page_number)

        get :index, category_id: category_id, page: page_number

        assigns(:posts).should == paginated_posts
      end
    end
  end


  describe "#show" do
    let(:new_post){ mock_model('Post') }
    let(:paginated_responses){ double('paginated_responses') }
    let(:mk_req){ get :show, id: post_id, category_id: category_id, page: page_number }

    before :each do
      Post.stub(:find).with(post_id).and_return(xpost)
      Post.stub(:new).and_return(new_post)
      Post.stub(:get_paginated_for_topic).with(xpost,page_number).and_return(paginated_responses)
    end

    it "assigns the requested main post to @current_post" do
      Post.should_receive(:find).with(post_id).and_return(xpost)
      
      mk_req
      assigns(:current_post).should eq(xpost)
    end

    it "assigns @current_post responses to posts" do
      Post.should_receive(:get_paginated_for_topic).with(xpost, page_number).and_return(paginated_responses)
      
      mk_req
      assigns(:posts).should eq(paginated_responses)
    end

    it "assigns empty post to @new_post" do
      Post.should_receive(:new).and_return(new_post)

      mk_req
      assigns(:post).should eq(new_post)
    end
  end


  describe "#new" do
    let(:mk_req) { get :new, category_id: category_id }

    before :each do
      Post.stub(:new).and_return(xpost)
    end 

    context "@category.present?" do
      context "user_signed_in?" do
        before :each do
          sign_in
        end 

        it "render #new" do
          Post.should_receive(:new)

          mk_req
          assigns(:post).should eq(xpost)
        end
      end
  
      context "!user_signed_in?" do
        before :each do
          sign_in nil
        end

        it "redirect_to login_path" do
          mk_req
          response.should redirect_to login_path
        end
      end
    end

    context "@category.nil?" do
      it "raises error" do
        expect{ get :new }.to raise_error
      end
    end
  end
  

  describe "#create" do
    let(:new_post){ mock_model('Post').as_new_record }
    let(:mk_req) { post :create, post: {title: 'Title', content: 'This is a content', user_id: '1', category_id: '1'}, category_id: category_id }

    context "@category.present?" do
      context "user_signed_in?" do
        before :each do
          sign_in

          Post.stub(:new).and_return(new_post)
          new_post.stub(:save).and_return(true)

          controller.stub(:after_save_redirect_url).and_return(category_post_path(category_id,post_id))
        end
  
        context "@post.valid?" do
          it "post.save" do
            Post.should_receive(:new).with(valid_atts)
            new_post.should_receive(:save)

            mk_req
            assigns(:post).should eq(new_post)
          end
          
          it "redirects to the new post" do
            Post.should_receive(:new).with(valid_atts)
            new_post.should_receive(:save)
            controller.should_receive(:after_save_redirect_url)
            
            mk_req
            
            response.should redirect_to category_post_path(category_id,post_id)
          end
        end

        context "!@post.valid?" do
          let(:mk_req){ post :create, post: {}, category_id: category_id }
          before :each do
            new_post.stub(:save).and_return(false)
          end

          it "@post.new_record?" do
            Post.should_receive(:new).with({})
            new_post.should_receive(:save)

            mk_req

            assigns(:post).should be_new_record
          end
          
          it "re-renders #new" do
            mk_req
            response.should render_template :new
          end
        end
      end
  
      context "!user_signed_in?" do
        it "redirect_to login_path" do
          mk_req
          response.should redirect_to login_path
        end
      end
    end

    context "@category.nil?" do
      it "raises error" do
        expect{ post :create, post: valid_atts }.to raise_error
      end
    end
  end


  describe "#update", focus: true do
    let(:valid_atts){ {'title' => 'Updated', 'user_id'=>'1' } }
    let(:mk_req){ put :update, post: valid_atts, category_id: category_id, id: post_id }

    context "@category.present?" do
      context "user_signed_in?" do
        context "@post.valid?" do
          context "current_user.is_admin?" do
            before :each do
              sign_in mock_model('User', is_admin?: true)
            end
            
            context "@post.parent_id?" do
              let(:mk_req){ put :update, post: valid_atts, category_id: category_id, id: resp_id }

              before :each do
                Post.stub(:find).and_return(resp)
                resp.stub(:update_attributes).with(valid_atts).and_return(true)
                controller.stub(:after_save_redirect).with(resp).and_return(category_post_path(category_id,post_id))
              end

              it "update_attributes and redirects to parent show view" do
                resp.should_receive(:update_attributes).with(valid_atts)
                controller.should_receive(:after_save_redirect).with(resp)

                mk_req
                response.should redirect_to category_post_path(category_id,post_id)
              end
            end

            context "!@post.parent_id?" do
              before :each do
                Post.stub(:find).and_return(xpost)
                xpost.stub(:update_attributes).with(valid_atts).and_return(true)
                controller.stub(:after_save_redirect).with(xpost).and_return(category_post_path(category_id,post_id))
              end

              it "update_attributes and redirects to parent show view" do
                xpost.should_receive(:update_attributes).with(valid_atts)
                controller.should_receive(:after_save_redirect).with(xpost)

                mk_req
                response.should redirect_to category_post_path(category_id,post_id)
              end
            end
          end # @current_user.is_admin?

          context "!current_user.is_admin?" do
            before :each do
              sign_in mock_model('User', is_admin?: false, id: 1)
            end

            context "@post.user == current_user" do
              context "@post.parent_id?" do
                let(:mk_req){ put :update, post: valid_atts, category_id: category_id, id: resp_id }

                before :each do
                  Post.stub(:find).and_return(resp)
                  resp.stub(:update_attributes).with(valid_atts).and_return(true)
                  controller.stub(:after_save_redirect).with(resp).and_return(category_post_path(category_id,post_id))
                end

                it "update_attributes and redirects to parent show view" do
                  resp.should_receive(:update_attributes).with(valid_atts)
                  controller.should_receive(:after_save_redirect).with(resp)

                  mk_req
                  response.should redirect_to category_post_path(category_id,post_id)
                end
              end

              context "!@post.parent_id?" do
                before :each do
                  Post.stub(:find).and_return(xpost)
                  xpost.stub(:update_attributes).with(valid_atts).and_return(true)
                  controller.stub(:after_save_redirect).with(xpost).and_return(category_post_path(category_id,post_id))
                end

                it "update_attributes and redirects to parent show view" do
                  xpost.should_receive(:update_attributes).with(valid_atts)
                  controller.should_receive(:after_save_redirect).with(xpost)

                  mk_req
                  response.should redirect_to category_post_path(category_id,post_id)
                end
              end
            end # @post.user == current_user

            context "@post.user != current_user" do
              let(:xpost) { mock_model('Post', id: 1, slug: post_id, user_id: 2) }
              let(:resp) { mock_model('Post', parent_id: xpost.id, slug: resp_id, user_id: 2) }

              before :each do
                Post.stub(:find).with(post_id).and_return(xpost) # Used by Cancan
              end

              it "redirect_to posts_path" do
                mk_req
                response.should redirect_to posts_path
              end
            end
          end
        end # @post.valid

        context "!@post.valid?" do
          let(:invalid_atts){ {'content' => ''} }

          context "current_user.is_admin?" do
            before :each do
              sign_in(mock_model('User',is_admin?: true, id: 1))
            end

            context "@post.parent_id?" do
              let(:mk_req){ put :update, post: invalid_atts, category_id: category_id, id: resp_id }

              before :each do
                Post.stub(:find).and_return(resp)
                resp.stub(:update_attributes).with(invalid_atts).and_return(false)
              end

              it "update_attributes and redirects to parent show view" do
                resp.should_receive(:update_attributes).with(invalid_atts)

                mk_req
                response.should render_template :edit
              end
            end

            context "!@post.parent_id?" do
              let(:mk_req){ put :update, post: invalid_atts, category_id: category_id, id: post_id }

              before :each do
                Post.stub(:find).and_return(xpost)
                xpost.stub(:update_attributes).with(invalid_atts).and_return(false)
              end

              it "update_attributes and redirects to parent show view" do
                xpost.should_receive(:update_attributes).with(invalid_atts)

                mk_req
                response.should render_template :edit
              end
            end
          end # current_user.is_admin?
          
          context "!current_user.is_admin?" do
            before :each do
              sign_in mock_model('User', is_admin?: false, id: 1)
            end

            context "@post.user == current_user" do
              context "@post.parent_id?" do
                let(:mk_req){ put :update, post: invalid_atts, category_id: category_id, id: resp_id }

                before :each do
                  Post.stub(:find).and_return(resp)
                  resp.stub(:update_attributes).with(invalid_atts).and_return(false)
                end

                it "re-renders #edit view" do
                  resp.should_receive(:update_attributes).with(invalid_atts)

                  mk_req
                  response.should render_template :edit
                end
              end

              context "!@post.parent_id?" do
                let(:mk_req){ put :update, post: invalid_atts, category_id: category_id, id: post_id }

                before :each do
                  Post.stub(:find).and_return(xpost)
                  xpost.stub(:update_attributes).with(invalid_atts).and_return(false)
                end

                it "re-renders #edit view" do
                  xpost.should_receive(:update_attributes).with(invalid_atts)

                  mk_req
                  response.should render_template :edit
                end
              end
            end # @post.user == current_user

            context "@post.user != current_user" do
              let(:xpost) { mock_model('Post', id: 1, slug: post_id, user_id: 2) }
              let(:resp) { mock_model('Post', parent_id: xpost.id, slug: resp_id, user_id: 2) }

              before :each do
                Post.stub(:find).with(post_id).and_return(xpost) # Used by Cancan
              end

              it "redirect_to posts_path" do
                mk_req
                response.should redirect_to posts_path
              end
            end # @post.user != current_user
          end # !current_user.is_admin?
        end
      end

      context "!user_signed_in?" do
        before :each do
          Post.stub(:find).and_return(xpost) # Used by Cancan
        end
        
        it "redirect_to login_path" do
          mk_req
          response.should redirect_to login_path
        end
      end
    end

    context "@category.nil?" do
      it "raises error" do
        expect{ put :update, post: valid_atts }.to raise_error
      end
    end
  end

=begin

  describe '#destroy' do
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