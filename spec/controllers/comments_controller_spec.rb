require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
    @comment = Comment.create!(
      content: 'content',
      user_id: @user.id,
      post_id: @post.id
    )
  end

  describe 'GET #index' do
    context 'as authorized user' do
      it 'responds successfully' do
        sign_in @user
        comments = Comment.where(post_id: @post.id)
        get :index, params: { id: @post.id }
        expect(response).to be_successful
        expect(response).to have_http_status '200'
        expect(assigns(:comments)).to eq comments
      end
    end

    context 'as guest user' do
      it 'redirects the page to /users/sign_in' do
        comments = Comment.where(post_id: @post.id)
        get :index, params: { id: @post.id }
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'GET #new' do
    context 'as authorized user' do
      it 'responds successfully' do
        sign_in @user
        get :new, params: { id: @post.id }
        expect(response).to be_successful
        expect(response).to have_http_status '200'
      end
    end

    context 'as guest user' do
      it 'redirect_to login-page' do
        get :new, params: { id: @post.id }
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
        comments = Comment.where(post_id: @post.id)
        expect {
          post :create, params: {
            id: @post.id,
            comment: {
              user_id: @user.id,
              post_id: @post.id,
              content: 'content'
            }
          }
        }.to change(comments, :count).by(1)
      end

      it 'redirect to post_show_page' do
        sign_in @user
        post :create, params: {
          id: @post.id,
          comment: {
            user_id: @user.id,
            post_id: @post.id,
            content: 'content'
          }
        }
        expect(response).to redirect_to(comments_path(@post))
      end
    end

    context 'as guest user' do
      it 'redirects the page to /users/sign_in' do
        post :create, params: { id: @post.id }
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
