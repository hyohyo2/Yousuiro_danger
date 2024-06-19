class Post < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  enum status: { danger: 0, safety: 1 }

  validates :image, presence: true
  # 全角の指定は可能か
  validates :post_code, presence: true, format: {with: /\A[0-9]+\z/, message: 'には半角数字を入力してください'}
  validates :prefecture_address, presence: true
  validates :city_address, presence: true
  validates :block_address, presence: true
  validates :detail, presence: true
  # validates :status, presence: true


  geocoded_by :full_address
  after_validation :geocode

  # 住所の特定はfull_addressで定義している3カラムから必要なため
  def full_address
    "#{prefecture_address} #{city_address} #{block_address}"
  end

  has_one_attached :image

  def get_image(width, height)
    image.variant(resize: "#{width}x#{height}!").processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
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

  # 投稿数
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) }
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) }
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) }
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) }
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) }

  # 通知機能
  after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end


end
