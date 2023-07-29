class UsersController < ApplicationController
  protect_from_forgery prepend: true
  before_action :authenticate_user!

  def index
    @all_users = User.all
  end

  def show
    @user = User.find(params[:id])
    @recent_post = @user.three_recent_posts
  end
end
