class CommentsController < ApplicationController

  before_action :set_post
  before_action :set_comment, only: [:edit, :destroy, :update,]

  def create
    #@post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment_params])
    @comment.user_id = current_user.id if current_user
    @comment.save

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def edit
    # @post = Post.find(params[:post_id])
    #@comment = Comment.find(params[:id])
  end

  def destroy
    # @post = Post.find(params[:post_id])
    #  @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to post_path(@post)
    else
      flash[:notice] = "something is wrong try again"
    end
  end

  def update
    #@post = Post.find(params[:post_id])
    #@comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      render action: 'edit'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end
