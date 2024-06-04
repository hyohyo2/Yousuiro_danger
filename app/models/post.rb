class Post < ApplicationRecord
  
  belongs_to :user
  
  enum status: { danger: 0, safety: 1 }
  
  validates :post_code, presence: true
  validates :prefecture_address, presence: true
  validates :city_address, presence: true
  validates :detail, presence: true
  validates :status, presence: true
  
  has_one_attached :image
  
end
