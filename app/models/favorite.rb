class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :post
  
  # 一つの投稿に一度しかいいねボタンが押せない
  validates :user_id, uniqueness: {scope: :post_id}
  
end
