class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only:[:followers]
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

  private

  # ゲストログイン時のアクセス制限
  def ensure_guest_user
    if current_user.guest_user
      redirect_to user_path(current_user.id), alert: "ゲストユーザーはご利用できません。"
    end
  end

end
