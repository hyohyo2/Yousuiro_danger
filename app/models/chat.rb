class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message, presence: true, length: { maximum: 60 }

  has_one :notification, as: :notifiable, dependent: :destroy

  after_create do
    create_notification(user_id: user_id)
  end

end
