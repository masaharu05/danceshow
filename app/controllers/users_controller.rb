class UsersController < ApplicationController

  before_action :authenticate_user!, :only => [:show, :index, :edit, :update]

  def index
    @users = User.all
    redirect_to posts_path
  end


  def show
    @user = User.find(params[:id])
    @posts = Post.page params[:page]
    @like_posts = @user.like_posts
  end


  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
    else
      redirect_to "/posts"
      flash[:alert] = "無効なユーザー"
    end
  end


  def update
    @user = User.find(params[:id])
    
    if @user.id == current_user.id
      @user.update(params.require(:user).permit(:user_name, :user_image, :self_introduction))
    else
      edirect_to "/posts"
      flash[:alert] = "無効なユーザー"
    end
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end


end
