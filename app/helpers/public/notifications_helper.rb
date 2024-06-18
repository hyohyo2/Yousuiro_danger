module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Post"
      "フォローしている#{notification.notifiable.user.name}さんが#{notification.notifiable.title}を投稿しました。"
    when "Favorite"
      "#{notification.notifiable.user.name}さんにいいねされました。"
    else
      "#{notification.notifiable.user.name}さんがコメントをしました"
    end
  end
end
