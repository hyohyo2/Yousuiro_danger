class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :destroy

  # 一つの投稿に一度しかいいねボタンが押せない
  validates :user_id, uniqueness: {scope: :post_id}

  # 通知機能(投稿したユーザーへ通知を行う)
  after_create do
    create_notification(user_id: post.user_id)
  end

end
