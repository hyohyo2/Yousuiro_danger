class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.page(params[:page]).per(10)

  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('id DESC').limit(4)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報の更新しました。"
      redirect_to admin_user_path(@user.id)
    else
      flash.now[:alert] = "ユーザー情報の更新に失敗しました。"
      render :edit
    end
  end

  def userpost
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :introduction, :is_active)
  end

end
