class Public::UsersController < ApplicationController
  def mypage
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
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
    @user = current_user
    @user.update(is_active: true)
    reset_session
    # フラッシュメッセージ導入
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
end
