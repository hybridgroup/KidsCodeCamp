require 'spec_helper'

shared_examples_for 'guest user' do
  it "lists all categories" do
    visit posts_path
    
    page.should have_content('Community')
    page.should have_css('th', :text =>'Category')
  end

  it "lists all posts for a category" do
    visit category_posts_path(category_id: post.category)
    
    page.should have_content('Community')
    page.should have_content(post.title)
    page.should have_css('th', :text =>'Topic')
  end
end

shared_examples_for 'logged in user' do
  it_behaves_like 'guest user'

  it "views a post with a comment form" do
    visit category_post_path(category_id: post.category, id: post)
    
    page.should have_content(post.title)
    page.should have_content('Add a response')
  end

  context 'Creates new responses/messages' do
    it "posts new responses" do
      visit category_post_path(category_id: post.category, id: post)

      fill_in 'post_content', with: new_post.content
      page.find('#new_post input[type=image]').click
      
      page.should have_content(post.title)
      page.should have_css('.post_content', text: new_post.content)
    end

    it "creates a new post within a category" do
      post = creates_a_post(category, new_post)
      page.should have_content(post.title)
    end
  end
end

describe "Posts" do
  let(:category){ create(:category_with_posts) }
  let(:post){ create(:topic) }
  let(:new_post){ build(:post) }

  context 'As a guest user' do
    it_behaves_like 'guest user'

    it "view a post with no comment form" do
      visit posts_path(category_id: post.category, id: post)
      
      page.should have_content(post.title)
      page.should_not have_content('Add a response')
    end
  end

  context 'As admin user' do
    before(:each) do
      sign_in(create(:user, is_admin: true))
    end

    it_behaves_like 'logged in user'

    it "deletes all posts" do
      deletes_post(post)

      page.should_not have_content(post.title)
    end

    it "edits all posts" do
      edits_post(post)                

      page.should have_content('New content')
    end
  end

  context 'As editor user' do
    before(:each) do
      sign_in
    end

    let(:post){ create(:topic) }
    
    it_behaves_like 'logged in user'

    it "deletes own posts" do
      post = creates_a_post(category, new_post)
      deletes_post(post)

      page.should_not have_content(post.title)
    end

    it "edits own posts" do
      post = creates_a_post(category, new_post)
      edits_post(post)

      page.should have_content('New content')
    end
  end
end

def creates_a_post(category, post)
  visit category_posts_path(category_id: category)
  
  click_link 'New Post'
  fill_in 'post_title', with: post.title
  fill_in 'post_content', with: post.content
  page.find('#new_post input[type=image]').click
  category.posts.last
end

def deletes_post(post)
  visit category_post_path(category_id: post.category, id: post)
  first('.topics').click_link 'Destroy'
end

def edits_post(post)
  visit category_post_path(category_id: post.category, id: post)

  first('.topics').click_link 'Edit'
  fill_in 'post_content', with: 'New content'
  page.find('.post_form input[type=image]').click
end
