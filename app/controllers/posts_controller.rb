class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user_posts = Post.includes(:comments).where(author_id: @user)
    @post_comments = Comment.includes(:author).where(post_id: @user_posts.ids)
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @post_comments = Comment.includes(:author).where(post_id: @post)
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

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
