class Public::UsersController < ApplicationController
  #before_action :authenticate_user! コメントアウト解除すること
  def mypage
    @user = current_user
    @posts = @user.posts.page(params[:page]).per(8)
    @post = @user.posts
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(8)
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
    # フラッシュメッセージ入れる
      redirect_to mypage_path(@user)
    else
      render :edit
    end
  end

  def unsubscribe
  end
  
  def withdraw
    current_user.update(is_active: false)
    reset_session
    # フラッシュメッセージ導入
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :introduction)
  end
  
end
