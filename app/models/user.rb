class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
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
  
  # ユーザー用検索機能(部分検索でステータスが有効のみ)
  def self.search_for(content)
    User.where('name LIKE ?', '%' + content + '%').where(is_active: true)
  end
  # 管理者用検索機能(部分検索でステータスが有効・無効どちらでも検索可能)
  def self.admin_search_for(content)
    User.where('name LIKE ?', '%' + content + '%')
  end
    
end
