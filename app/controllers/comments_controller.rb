class CommentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: @post.id)
  end

  def new
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    if @comment.save
      flash[:success] = 'Commented!!'
      redirect_to comments_path(@post)
    else
      flash.now[:danger] = 'Failed to comment!!'
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
