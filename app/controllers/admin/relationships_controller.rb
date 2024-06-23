class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!
  # フォロー一覧
  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(20).order('users.id DESC')
  end
  # フォロワー一覧
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(20).order('users.id DESC')
  end
end
