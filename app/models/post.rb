class Post < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy

  enum status: { danger: 0, safety: 1 }

  validates :image, presence: true
  # 全角の指定は可能か
  validates :post_code, presence: true, length: { is: 7 }
  validates :prefecture_address, presence: true
  validates :city_address, presence: true
  validates :detail, presence: true
  validates :status, presence: true

  has_one_attached :image


  def get_image(width, height)
    image.variant(resize: "#{width}x#{height}!").processed
  end

  
  def self.search_for(content, model)
    # 検索機能(部分検索のみ)
    # 都道府県・市区町村・以降の住所どこを検索しても表示される
    if model == "post"
      Post.where('prefecture_address LIKE ? OR city_address LIKE ? OR block_address LIKE ?', '%' + content + '%', '%' + content + '%', '%' + content + '%')
    elsif model == "post_code"
      # 検索機能(郵便番号だけは完全一致検索)
      Post.where('post_code = ?', content)
    end
  end
  
end
