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
     # 退会になると非表示
    unless @user.is_active
      redirect_to user_path(current_user), alert: "指定のユーザーは存在しないか退会済みです。"
    end
  end

  # フォロワーユーザー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).per(10).order('users.id DESC')
     # 退会になると非表示
    unless @user.is_active
      redirect_to user_path(current_user), alert: "指定のユーザーは存在しないか退会済みです。"
    end
  end
end
