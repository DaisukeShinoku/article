class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'Post created!!'
      redirect_to post_url(@post)
    else
      flash.now[:danger] = 'Failed to create Post!!'
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = 'Post updated!!'
      redirect_to post_url(@post)
    else
      flash.now[:danger] = 'Failed to update Post!!'
      render 'edit'
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :text)
    end
end
