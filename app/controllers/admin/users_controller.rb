class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  # ユーザー一覧
  def index
    @users = User.page(params[:page]).per(15)
  end

  # ユーザー詳細
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('id DESC').limit(3)
  end

  # ユーザー情報編集
  def edit
    @user = User.find(params[:id])
  end

  # ユーザー情報更新
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # ステータスが有効だったら
      if @user.is_active == true
        flash[:notice] = "ユーザー情報を更新しました。"
      # ステータスが退会だったら
      else
        flash[:notice] = "ユーザー情報を更新しました。"
        # ステータスを退会にすると以下のデータが削除にされる
        # 投稿
        @user.posts.destroy_all
        # コメント
        @user.post_comments.destroy_all
        # お気に入り
        @user.favorites.destroy_all
        # フォローユーザー
        @user.followings.destroy_all
        # フォロワー
        @user.followers.destroy_all
        # チャットルーム(ユーザーと相手ユーザー)
        @user.user_rooms.each do |user_room|
          user_room.room.destroy
        end
        @user.user_rooms.destroy_all
        # チャット内容
        @user.chats.destroy_all
        # 通知
        @user.notifications.destroy_all
      end
      redirect_to admin_user_path(@user.id)
    # ステータス更新に失敗したら
    else
      flash.now[:alert] = "ユーザー情報の更新に失敗しました。"
      render :edit
    end
  end
  # ユーザーの投稿一覧
  def userpost
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(12).order('id DESC')
    # 退会になると非表示
    unless @user.is_active
      redirect_to admin_user_path(@user.id), alert: "指定のユーザーは存在しないか退会済みです。"
    end
  end

  # お気に入り投稿一覧
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorites).page(params[:page]).per(12).order('id DESC')
    # 退会になると非表示
    unless @user.is_active
      redirect_to admin_user_path(@user.id), alert: "指定のユーザーは存在しないか退会済みです。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :introduction, :is_active)
  end

end
