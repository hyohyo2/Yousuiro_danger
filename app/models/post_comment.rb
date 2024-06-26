class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :comment, presence: true, length: { maximum: 60 }

  # 通知機能(コメントされたら投稿したユーザーへ通知)
  after_create do
    create_notification(user_id: post.user_id)
  end

end
