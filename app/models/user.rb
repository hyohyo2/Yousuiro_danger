class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # フォローの関連付け・取得
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  # フォロワーの関連付け・取得
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_one_attached :profile_image

  validates :name, presence: true
  validates :introduction, length: { maximum: 30 }
  validates :is_active, inclusion: { in: [true,false] }

  #プロフィール画像
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize: "#{width}x#{height}!").processed
  end
  
  # フォロー関係
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  
  def unfollow(user)
    active_relationships.find_by(followed_id :user.id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end

  # ゲストログイン用
  def self.guest
    User.find_or_create_by!(email: ENV["GUEST_USER_EMAIL"]) do |user|
      user.name = 'ゲストユーザー'
      user.password = ENV["GUEST_USER_PASSWORD"]
    end
  end
  
  def guest_user
    email == ENV["GUEST_USER_EMAIL"]
  end

  # ユーザー用検索機能(部分検索でステータスが有効のみ)
  def self.search_for(content)
    User.where('name LIKE ?', '%' + content + '%').where(is_active: true)
  end
  # 管理者用検索機能(部分検索でステータスが有効・無効どちらでも検索可能)
  def self.admin_search_for(content)
    User.where('name LIKE ?', '%' + content + '%')
  end

end
