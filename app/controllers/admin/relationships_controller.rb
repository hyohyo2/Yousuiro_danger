class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!
  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(10).order('users.id DESC')
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10).order('users.id DESC')
  end
end
