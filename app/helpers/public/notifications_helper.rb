module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Post"
      "#{notification.notifiable.user.name}さんが[#{notification.notifiable.status_i18n}]を投稿しました。"
    when "Favorite"
      "#{notification.notifiable.user.name}さんが[#{notification.notifiable.post.status_i18n}]#{notification.notifiable.post.prefecture_address}#{notification.notifiable.post.city_address}#{notification.notifiable.post.block_address}にいいねしました。"
    else
      "#{notification.notifiable.user.name}さんがコメントをしました"
    end
  end
end
