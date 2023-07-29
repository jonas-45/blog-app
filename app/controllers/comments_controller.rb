class CommentsController < ApplicationController
  before_action :find_comment, only: [:destroy]

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post = Post.find(params[:post_id])

    if @comment.save
      flash[:notice] = 'Comment added successfully!'
      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
    else
      flash[:alert] = "Couln't add Comment!"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])

    # @comment = current_user.comments.find_by(id: params[:id])
    if @comment&.destroy
      flash[:success] = 'Comment deleted!'
      @comment.post.decrement!(:comments_counter) # Decrease the comments count by 1 for the post
    else
      flash[:danger] = 'Comment not deleted!'
    end
  end
  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
