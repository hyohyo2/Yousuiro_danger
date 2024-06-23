module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    # フォローユーザーが投稿したときの通知表示
    when "Post"
      "#{notification.notifiable.user.name}さんが[#{notification.notifiable.status_i18n}]”#{notification.notifiable.prefecture_address}#{notification.notifiable.city_address}#{notification.notifiable.block_address}”を投稿しました"
    # 投稿に対してお気に入り押されたときの通知表示
    when "Favorite"
      "#{notification.notifiable.user.name}さんが[#{notification.notifiable.post.status_i18n}]”#{notification.notifiable.post.prefecture_address}#{notification.notifiable.post.city_address}#{notification.notifiable.post.block_address}”にいいねしました"
    # 投稿に対してコメントがされたときの通知表示
    when "PostComment"
      "#{notification.notifiable.user.name}さんが[#{notification.notifiable.post.status_i18n}]”#{notification.notifiable.post.prefecture_address}#{notification.notifiable.post.city_address}#{notification.notifiable.post.block_address}”にコメントをしました"
    # フォローされたときの通知表示
    when "Relationship"
      "#{notification.notifiable.follower.name}さんからフォローされました"
    # DMを受信したときの
    else
      "#{notification.notifiable.user.name}さんからメッセージがきました"
    end
  end
end
