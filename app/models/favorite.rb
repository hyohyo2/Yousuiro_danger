class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :destroy
  
  # 一つの投稿に一度しかいいねボタンが押せない
  validates :user_id, uniqueness: {scope: :post_id}
  
end
