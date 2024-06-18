class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    case notification.notifiable_type
    when "Post"
      redirect_to timeline_path(notification.notifiable)
    when "Favorite"
      redirect_to user_path(notification.notifiable.user)
    else
      redirect_to user_path(notification.notifiable.user)
    end
  end
end
