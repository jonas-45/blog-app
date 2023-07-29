class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @user_posts = Post.includes(:comments).where(author_id: @user)
    @post_comments = Comment.includes(:author).where(post_id: @user_posts.ids)
    authorize! :read, Post
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @post_comments = Comment.includes(:author).where(post_id: @post)
    @user = current_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      flash[:notice] = 'Post created successfully!'
      redirect_to user_posts_path(current_user)
    else
      flash[:alert] = "Couln't create post!"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # @post.destroy
    @post = Post.find(params[:id])
    if @post&.destroy
      flash[:success] = 'Post deleted!'
      @post.author.decrement!(:posts_counter) # Decrease the post count by 1 for the post's author
    else
      flash[:danger] = 'Post not deleted!'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
