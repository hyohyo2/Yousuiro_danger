class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  # フォローする
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
  end
  
  # フォローを解除
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
  end
  
  # フォローユーザー一覧
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).per(10).order('users.id DESC')
  end
  
  # フォロワーユーザー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).per(10).order('users.id DESC')
  end
end
