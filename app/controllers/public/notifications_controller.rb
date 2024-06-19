class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page]).per(20)
  end

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    case notification.notifiable_type
    when "Post"
      redirect_to post_path(notification.notifiable)
    when "Favorite"
      redirect_to post_path(notification.notifiable.post)
    else
      redirect_to post_path(notification.notifiable.post)
    end
  end
  # 通知の全削除
  def destroy
    @notifications = current_user.notifications.destroy_all
    redirect_to notifications_path
  end


end
