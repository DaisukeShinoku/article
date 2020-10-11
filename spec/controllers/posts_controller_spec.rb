require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
  end

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
      get :show, params: { id: @post.id }
      expect(response).to be_successful
      expect(response).to have_http_status '200'
    end
  end

  describe 'GET #new' do
    context 'as authorized user' do
      it 'responds successfully' do
        sign_in @user
        get :new
        expect(response).to be_successful
        expect(response).to have_http_status '200'
      end
    end

    context 'as guest user' do
      it 'redirect_to login-page' do
        get :new
        expect(response).not_to be_successful
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'POST #create' do
    context 'as authorized user' do
      it 'add a new post' do
        sign_in @user
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
        sign_in @user
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

    context 'as guest user' do
      it 'redirects the page to /users/sign_in' do
        post :create
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'GET #edit' do
    context 'as authorized user' do
      it 'responds successfully' do
        sign_in @user
        get :edit, params: { id: @post.id }
        expect(response).to be_successful
        expect(response).to have_http_status '200'
      end
    end

    context 'as guest user' do
      it 'redirects the page to /users/sign_in' do
        get :edit, params: { id: @post.id }
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'PATCH #update' do
    context 'as authorized user' do
      it 'updates updated post' do
        sign_in @user
        post_params = { title: 'updated title', text: 'updated text' }
        patch :update, params: { id: @post.id, post: post_params }
        expect(@post.reload.title).to eq 'updated title'
        expect(@post.reload.text).to eq 'updated text'
      end
    end

    context 'as guest user' do
      it 'redirects the page to /users/sign_in' do
        post_params = { title: 'updated title', text: 'updated text' }
        patch :update, params: { id: @post.id, article: post_params }
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
