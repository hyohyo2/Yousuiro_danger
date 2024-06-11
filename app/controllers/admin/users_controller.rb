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
      if @user.is_active == true
        flash[:notice] = "ユーザー情報を更新しました。"
      else
        flash[:notice] = "ユーザー情報を更新しました。"
        @user.posts.destroy_all
        @user.post_comments.destroy_all
      end
      redirect_to admin_user_path(@user.id)
    else
      flash.now[:alert] = "ユーザー情報の更新に失敗しました。"
      render :edit
    end
  end

  def userpost
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10).order('id DESC')
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :introduction, :is_active)
  end

end
