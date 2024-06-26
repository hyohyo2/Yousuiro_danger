class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:edit, :update]
  before_action :ensure_guest_user, only:[:edit, :userpost]
  # ユーザー詳細
  def show
    @user = User.find(params[:id])
    # 退会になると非表示
    unless @user.is_active
      redirect_to user_path(current_user), alert: "指定のユーザーは存在しないか退会済みです。"
    end

    # 新着順
    @posts = @user.posts.order('id DESC').limit(4)
  end

  # ユーザー編集
  def edit
    @user = current_user
  end

  # ユーザー情報更新
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

  # 退会確認
  def unsubscribe
  end

  # 退会処理
  def withdraw
    # ユーザが退会ステータスになったらユーザの以下のデータは削除される
    current_user.update(is_active: false)
    # 投稿
    current_user.posts.destroy_all
    # コメント
    current_user.post_comments.destroy_all
    # お気に入り一覧
    current_user.favorites.destroy_all
    # フォローユーザー
    current_user.followings.destroy_all
    # フォロワー
    current_user.followers.destroy_all
    # チャットルーム(ユーザーと相手ユーザー)
    current_user.user_rooms.each do |user_room|
      user_room.room.destroy
    end
    current_user.user_rooms.destroy_all
    # チャット内容
    current_user.chats.destroy_all
    # 通知
    current_user.notifications.destroy_all
    reset_session
    flash[:notice] = "退会処理をしました。ご利用ありがとうございました。"
    redirect_to new_user_registration_path
  end

  # お気に入りに登録した投稿一覧
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorites).page(params[:page]).per(10).order('id DESC')
    # 退会になると非表示
    unless @user.is_active
      redirect_to user_path(current_user), alert: "指定のユーザーは存在しないか退会済みです。"
    end
  end

  # ユーザーの全投稿一覧
  def userpost
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10).order('id DESC')
    # 退会になると非表示
    unless @user.is_active
      redirect_to user_path(current_user), alert: "指定のユーザーは存在しないか退会済みです。"
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :introduction)
  end

  # 他ユーザからのアクセスの制限
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id), alert: "指定のページはご利用できません"
    end
  end

  # ゲストユーザーログイン時アクセスを制限
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user
      redirect_to user_path(current_user.id), alert: "ゲストユーザーはご利用できません。"
    end
  end
end
