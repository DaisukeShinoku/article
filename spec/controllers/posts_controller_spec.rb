require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    it 'responds successfully' do
      posts = Post.all
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status '200'
      expect(assigns(:posts)).to eq posts
    end
  end

  describe 'GET #show' do
    it 'responds successfully' do
      post = create(:post)
      get :show, params: { id: post.id }
      expect(response).to be_successful
      expect(response).to have_http_status '200'
      expect(assigns(:post)).to eq post
    end
  end

  describe 'GET #new' do
    it 'responds successfully' do
      get :new
      expect(response).to be_successful
      expect(response).to have_http_status '200'
    end
  end

  describe 'POST #create' do
    it 'add a new post' do
      posts = Post.all
      expect {
        post :create, params: {
          post: {
            title: 'title',
            text: 'text'
          }
        }
      }.to change(posts, :count).by(1)
    end

    it 'redirect to post_show_page' do
      post :create, params: {
        post: {
          title: 'title',
          text: 'text'
        }
      }
      post = Post.last
      expect(response).to redirect_to(post_path(post))
    end
  end

  describe 'GET #edit' do
    it 'responds successfully' do
      post = create(:post)
      get :edit, params: { id: post.id }
      expect(response).to be_successful
      expect(response).to have_http_status '200'
      expect(assigns(:post)).to eq post
    end
  end

  describe 'PATCH #update' do
    let(:update) do
      {
        title: 'update title',
        text: 'update text'
      }
    end

    it 'updates updated post' do
      post :create, params: {
        post: {
          title: 'title',
          text: 'text'
        }
      }
      @post = Post.last
      patch :update, params: { id: @post.id, post: update }
      @post.reload
      expect(@post.title).to eq update[:title]
      expect(@post.text).to eq update[:text]
    end
  end
end
