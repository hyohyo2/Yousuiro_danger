module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Post"
      "フォローしている#{notification.notifiable.user.name}さんが#{notification.notifiable.title}を投稿しました。"
    when "Favorite"
      "#{notification.notifiable.post.status}の#{notification.notifiable.post.prefecture_address}#{notification.notifiable.post.city_address}#{notification.notifiable.post.block_address}の投稿が#{notification.notifiable.user.name}さんにいいねされました。"
    else
      "#{notification.notifiable.user.name}さんがコメントをしました"
    end
  end
end
