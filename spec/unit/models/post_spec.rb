require 'spec_helper'

describe Post, type: :model do
  let(:post){
    p = Post.new(title: 'This is a title', content: 'This is a content', user_id: 1)
    p.stub(:category).and_return(mock_model('Category'))
    p
  }
  subject { post }

  it 'is valid with defined attributes' do
    should be_valid
  end
  
  it 'is invalid without a title' do
    subject.title = ''
    should_not be_valid
  end

  it 'is invalid with a title more than 100 chars long' do
    subject.title = 'x' * 101
    should_not be_valid
  end

  it 'is invalid with a title less than 2 chars long' do
    subject.title = 'x'
    should_not be_valid
  end

  it 'is invalid without content' do
    subject.content = ''
    should_not be_valid
  end

  it 'is invalid without a Category' do
    post.stub(:category)
    post.should_not be_valid
  end

  it { should respond_to :title }
  it { should respond_to :content }
  it { should respond_to :slug }
  
  context '#get_paginated_for_category' do
    let(:page_number){ "1" }
    let(:posts){ mock_model('Post') }
    let(:scoped_posts){ double('scoped_posts') }
    let(:paginated_posts){ double('paginated_posts') }
    let(:category){ mock_model('Category', id: 1) }

    before :each do
      Post.stub(:where).and_return(scoped_posts)
      scoped_posts.stub(:paginate).and_return(paginated_posts)
      paginated_posts.stub(:order)
    end
    
    it 'returns paginated' do
      Post.should_receive(:where).with({:parent_id => nil, :category_id => category})
      scoped_posts.should_receive(:paginate).with(:page => page_number, :per_page =>12)
      paginated_posts.should_receive(:order).with('created_at DESC')

      Post.get_paginated_for_category(category, page_number)
    end
  end
end