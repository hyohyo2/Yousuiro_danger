class Post < ApplicationRecord
  
  belongs_to :user
  
  enum status: { danger: 0, safety: 1 }
  
  validates :image, presence: true
  validates :post_code, presence: true
  validates :prefecture_address, presence: true
  validates :city_address, presence: true
  validates :detail, presence: true
  validates :status, presence: true
  
  has_one_attached :image
  
  
  def get_image(width, height)
    image.variant(resize: "#{width}x#{height}!").processed
  end
  
end
