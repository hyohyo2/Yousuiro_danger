class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!
  # フォロー一覧
  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(15).order('users.id DESC')
    # 退会になると非表示
    unless @user.is_active
      redirect_to admin_user_path(@user.id), alert: "指定のユーザーは存在しないか退会済みです。"
    end
  end
  # フォロワー一覧
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(15).order('users.id DESC')
    # 退会になると非表示
    unless @user.is_active
      redirect_to admin_user_path(@user.id), alert: "指定のユーザーは存在しないか退会済みです。"
    end
  end
end
