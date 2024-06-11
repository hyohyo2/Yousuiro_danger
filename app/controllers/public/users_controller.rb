class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:edit, :update]
  def show
    @current_user = current_user
    @user = User.find(params[:id])
    # 新着順
    @posts = @user.posts.page(params[:page]).per(8).order('id DESC')
  end

  def edit
    @current_user = current_user
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報の更新しました。"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "ユーザー情報の更新に失敗しました。"
      render :edit
    end
  end

  def unsubscribe
    @current_user = current_user
  end

  def withdraw
    current_user.update(is_active: false)
    # ユーザが退会ステータスになったらユーザの投稿は削除される
    current_user.posts.destroy_all
    current_user.post_comments.destroy_all
    reset_session
    flash[:notice] = "退会処理をしました。ご利用ありがとうございました。"
    redirect_to new_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :introduction)
  end
  # 他ユーザからのアクセスの制限
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
