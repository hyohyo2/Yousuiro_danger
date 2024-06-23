class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  # 通知一覧
  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page]).per(20)
  end

  # 通知の更新
  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    case notification.notifiable_type
    # フォローユーザーが投稿
    when "Post"
      redirect_to post_path(notification.notifiable)
    # 投稿がお気に入り登録されたら
    when "Favorite"
      redirect_to post_path(notification.notifiable.post)
    # 投稿にコメントがされたら
    when "PostComment"
      redirect_to post_path(notification.notifiable.post)
    # ユーザーからフォローされたら
    when "Relationship"
      redirect_to user_path(notification.notifiable.follower)
    # DMを受信したら
    else
      redirect_to chat_path(notification.notifiable.user)
    end
  end
  
  # 通知の全削除
  def destroy
    @notifications = current_user.notifications.destroy_all
    redirect_to notifications_path
  end
end
