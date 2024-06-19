module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Post"
      "#{notification.notifiable.user.name}さんが[#{notification.notifiable.status_i18n}]”#{notification.notifiable.prefecture_address}#{notification.notifiable.city_address}#{notification.notifiable.block_address}”を投稿しました。"
    when "Favorite"
      "#{notification.notifiable.user.name}さんが[#{notification.notifiable.post.status_i18n}]”#{notification.notifiable.post.prefecture_address}#{notification.notifiable.post.city_address}#{notification.notifiable.post.block_address}”にいいねしました。"
    else
      "#{notification.notifiable.user.name}さんが[#{notification.notifiable.post.status_i18n}]”#{notification.notifiable.post.prefecture_address}#{notification.notifiable.post.city_address}#{notification.notifiable.post.block_address}”にコメントをしました"
    end
  end
end
