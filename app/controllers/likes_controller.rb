class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new
    @like.author = current_user
    if @like.save
      flash[:notice] = 'Like added successfully!'
      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
    else
      flash[:alert] = "Couldn't add a like!"
      puts @like.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end
end
