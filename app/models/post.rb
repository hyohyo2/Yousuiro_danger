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

  # 検索機能(部分検索のみ)
  # 都道府県・市区町村・以降の住所どこを検索しても表示される
  def self.search_for(content)
      Post.where('prefecture_address LIKE ? OR city_address LIKE ? OR block_address LIKE ?', '%' + content + '%', '%' + content + '%', '%' + content + '%')
  end
end
